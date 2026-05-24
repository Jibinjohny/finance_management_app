import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/transaction_provider.dart';
import '../providers/account_provider.dart';
import '../providers/goal_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class NetWorthLineChart extends StatefulWidget {
  const NetWorthLineChart({super.key});

  @override
  State<NetWorthLineChart> createState() => _NetWorthLineChartState();
}

class _NetWorthLineChartState extends State<NetWorthLineChart> {
  bool _isMonthly = false;
  bool _isNetWorthMode = true;

  // Touch scrubbing state
  int? _touchedIndex;
  int? _lastHapticIndex;

  // ── Formatting ────────────────────────────────────────────────
  String _fmt(double val) {
    final abs = val.abs();
    if (abs >= 1000000) return '${(val / 1000000).toStringAsFixed(2)}M';
    if (abs >= 1000) return '${(val / 1000).toStringAsFixed(1)}K';
    return val.toStringAsFixed(0);
  }

  // ── Build ─────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final goalProvider    = Provider.of<GoalProvider>(context);
    final txProvider      = Provider.of<TransactionProvider>(context);
    final sym             = CurrencyHelper.getSymbol(context);

    final currentNetWorth =
        accountProvider.totalNetWorth + goalProvider.totalGoalAmount;

    final data = _isNetWorthMode
        ? (_isMonthly
            ? _getMonthlyNetWorth(txProvider, currentNetWorth)
            : _getDailyNetWorth(txProvider, currentNetWorth))
        : (_isMonthly
            ? _getMonthlyCashFlow(txProvider)
            : _getDailyCashFlow(txProvider));

    // Determine which index to display in header (touched or latest)
    final int idx =
        (_touchedIndex != null && _touchedIndex! < data.length)
            ? _touchedIndex!
            : (data.isNotEmpty ? data.length - 1 : 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header: compact change badge at rest, full value on touch ──
        if (data.isNotEmpty)
          _buildHeader(data: data, idx: idx, sym: sym),

        const SizedBox(height: 10),

        // ── Chart ─────────────────────────────────────────────
        SizedBox(
          height: 200,
          child: data.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noDataAvailable,
                    style: GoogleFonts.inter(
                        color: Colors.white54, fontSize: 13),
                  ),
                )
              : LineChart(
                  _buildChartData(data, context),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                ),
        ),

        const SizedBox(height: 14),

        // ── Filter Chips (below chart) ─────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              _chip(
                label: AppLocalizations.of(context)!.netWorth,
                selected: _isNetWorthMode,
                onTap: () => _switchMode(() => _isNetWorthMode = true),
              ),
              const SizedBox(width: 8),
              _chip(
                label: 'Cash Flow',
                selected: !_isNetWorthMode,
                onTap: () => _switchMode(() => _isNetWorthMode = false),
              ),
            ]),
            Row(children: [
              _chip(
                label: '7D',
                selected: !_isMonthly,
                onTap: () => _switchMode(() => _isMonthly = false),
              ),
              const SizedBox(width: 8),
              _chip(
                label: '6M',
                selected: _isMonthly,
                onTap: () => _switchMode(() => _isMonthly = true),
              ),
            ]),
          ],
        ),
      ],
    );
  }

  void _switchMode(VoidCallback change) {
    setState(() {
      change();
      _touchedIndex = null;
      _lastHapticIndex = null;
    });
  }

  // ── Header: change badge at rest / scrub value on touch ──────
  Widget _buildHeader({
    required List<Map<String, dynamic>> data,
    required int idx,
    required String sym,
  }) {
    final isTouched = _touchedIndex != null;

    // Always compute change from first → last (rest) or first → touched (scrub)
    String changeLabel = '';
    Color  changeColor = Colors.white54;
    String touchDate   = '';
    String touchValue  = '';

    if (data.length > 1) {
      if (_isNetWorthMode) {
        final start = data.first['value'] as double;
        final end   = data[idx]['value']  as double;
        final diff  = end - start;
        final pct   = start != 0 ? (diff / start.abs() * 100) : 0.0;
        final sign  = diff >= 0 ? '+' : '';
        changeLabel = '$sign$sym${_fmt(diff)} (${pct.toStringAsFixed(1)}%)';
        changeColor = diff >= 0
            ? const Color(0xFF03DAC6)
            : const Color(0xFFFF5E62);
        if (isTouched) {
          touchDate  = data[idx]['label'] as String;
          touchValue = '$sym${_fmt(end)}';
        }
      } else {
        final inc  = data[idx]['income']  as double;
        final exp  = data[idx]['expense'] as double;
        final net  = inc - exp;
        final sign = net >= 0 ? '+' : '';
        changeLabel = '${sign}Net $sym${_fmt(net)}';
        changeColor = net >= 0
            ? const Color(0xFF03DAC6)
            : const Color(0xFFFF5E62);
        if (isTouched) {
          touchDate  = data[idx]['label'] as String;
          touchValue = '+$sym${_fmt(inc)}  −$sym${_fmt(exp)}';
        }
      }
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      child: isTouched
          // ── Scrub state: show date + value pill ────────────
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.14),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    touchDate,
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 1,
                    height: 12,
                    color: Colors.white24,
                  ),
                  Text(
                    touchValue,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Change badge inline
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: changeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      changeLabel,
                      style: GoogleFonts.inter(
                        color: changeColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            )
          // ── Rest state: compact change badge only ──────────
          : Row(
              children: [
                if (changeLabel.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: changeColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: changeColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          changeColor == const Color(0xFF03DAC6)
                              ? Icons.trending_up_rounded
                              : Icons.trending_down_rounded,
                          color: changeColor,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          changeLabel,
                          style: GoogleFonts.inter(
                            color: changeColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  _isMonthly ? 'vs 6 months ago' : 'vs 7 days ago',
                  style: GoogleFonts.inter(
                    color: Colors.white30,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
    );
  }

  // ── Chart Data ────────────────────────────────────────────────
  LineChartData _buildChartData(
      List<Map<String, dynamic>> data, BuildContext context) {
    double minVal = double.infinity, maxVal = -double.infinity;

    if (_isNetWorthMode) {
      for (final item in data) {
        final v = item['value'] as double;
        if (v < minVal) minVal = v;
        if (v > maxVal) maxVal = v;
      }
    } else {
      for (final item in data) {
        final inc = item['income']  as double;
        final exp = item['expense'] as double;
        if (inc < minVal) minVal = inc;
        if (exp < minVal) minVal = exp;
        if (inc > maxVal) maxVal = inc;
        if (exp > maxVal) maxVal = exp;
      }
    }

    if (minVal == double.infinity)  minVal = 0;
    if (maxVal == -double.infinity) maxVal = 1000;

    double range = maxVal - minVal;
    if (range == 0) range = 100;
    final minY = (minVal - range * 0.2).clamp(0.0, double.infinity);
    final maxY = maxVal + range * 0.2;
    final yInterval = (maxY - minY) / 4;

    final isGrowth = _isNetWorthMode &&
        data.length > 1 &&
        (data.last['value'] as double) >= (data.first['value'] as double);

    final accentColor =
        isGrowth ? const Color(0xFF03DAC6) : const Color(0xFFFF5E62);
    final glowColor =
        isGrowth ? const Color(0xFF81C784) : const Color(0xFFE57373);

    // ── Touch interaction ─────────────────────────────────────
    final lineTouchData = LineTouchData(
      touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
        if (event is FlTapUpEvent ||
            event is FlLongPressEnd ||
            event is FlPanEndEvent) {
          if (mounted) setState(() => _touchedIndex = null);
          return;
        }
        final spots = response?.lineBarSpots;
        if (spots != null && spots.isNotEmpty) {
          final newIdx = spots.first.x.toInt();
          if (newIdx != _lastHapticIndex) {
            HapticFeedback.selectionClick();
            _lastHapticIndex = newIdx;
          }
          if (mounted) setState(() => _touchedIndex = newIdx);
        }
      },
      // Suppress the built-in tooltip — value is shown in our header
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (_) => Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        getTooltipItems: (spots) => spots.map((_) => null).toList(),
      ),
      // Custom indicator: dashed crosshair + glowing dot
      getTouchedSpotIndicator:
          (LineChartBarData barData, List<int> spotIndexes) {
        return spotIndexes.map((i) {
          final color =
              barData.gradient?.colors.first ?? accentColor;
          return TouchedSpotIndicatorData(
            // Vertical crosshair line
            FlLine(
              color: color.withValues(alpha: 0.4),
              strokeWidth: 1.5,
              dashArray: [5, 4],
            ),
            // Outer glow dot
            FlDotData(
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                radius: 7,
                color: color.withValues(alpha: 0.25),
                strokeWidth: 2.5,
                strokeColor: color,
              ),
            ),
          );
        }).toList();
      },
    );

    // ── Axes ─────────────────────────────────────────────────
    final titlesData = FlTitlesData(
      show: true,
      topTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles:
          const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      // Y axis — abbreviated values
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 34,
          interval: yInterval > 0 ? yInterval : 1,
          getTitlesWidget: (value, meta) {
            if (value == meta.min || value == meta.max) {
              return const SizedBox.shrink();
            }
            final abs = value.abs();
            String label;
            if (abs >= 1000000) {
              label = '${(value / 1000000).toStringAsFixed(1)}M';
            } else if (abs >= 1000) {
              label = '${(value / 1000).toStringAsFixed(1)}K';
            } else {
              label = value.toStringAsFixed(0);
            }
            return SideTitleWidget(
              meta: meta,
              space: 4,
              child: Text(
                label,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),

      // X axis — all labels, interval:1 prevents duplicates
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          interval: 1,
          getTitlesWidget: (value, meta) {
            if (value != value.roundToDouble()) return const SizedBox.shrink();
            final index = value.toInt();
            if (index < 0 || index >= data.length) {
              return const SizedBox.shrink();
            }
            final isTouched = index == _touchedIndex;
            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 150),
                style: GoogleFonts.inter(
                  color: isTouched
                      ? accentColor
                      : Colors.white.withValues(alpha: 0.4),
                  fontSize: isTouched ? 10 : 9,
                  fontWeight: isTouched
                      ? FontWeight.bold
                      : FontWeight.w500,
                ),
                child: Text(data[index]['label'] as String),
              ),
            );
          },
        ),
      ),
    );

    // ── Grid ─────────────────────────────────────────────────
    final gridData = FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: yInterval > 0 ? yInterval : 1,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Colors.white.withValues(alpha: 0.07),
        strokeWidth: 1,
        dashArray: [4, 6],
      ),
    );

    // ── Lines ─────────────────────────────────────────────────
    final bars = _isNetWorthMode
        ? [
            LineChartBarData(
              spots: List.generate(data.length, (i) =>
                  FlSpot(i.toDouble(), data[i]['value'] as double)),
              isCurved: true,
              curveSmoothness: 0.35,
              barWidth: 3,
              isStrokeCapRound: true,
              gradient: LinearGradient(colors: [accentColor, glowColor]),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  // Show a small dot at every point, larger if touched
                  final isTouched = index == _touchedIndex;
                  return FlDotCirclePainter(
                    radius: isTouched ? 0 : 2.5, // touched dot handled by indicator
                    color: isTouched
                        ? Colors.transparent
                        : accentColor.withValues(alpha: 0.6),
                    strokeWidth: 1.5,
                    strokeColor: isTouched
                        ? Colors.transparent
                        : Colors.white.withValues(alpha: 0.4),
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    accentColor.withValues(alpha: 0.22),
                    accentColor.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ]
        : [
            // Income line — jade teal
            LineChartBarData(
              spots: List.generate(data.length, (i) =>
                  FlSpot(i.toDouble(), data[i]['income'] as double)),
              isCurved: true,
              curveSmoothness: 0.35,
              barWidth: 3,
              isStrokeCapRound: true,
              gradient: const LinearGradient(
                  colors: [Color(0xFF03DAC6), Color(0xFF81C784)]),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: index == _touchedIndex ? 0 : 2.5,
                  color: const Color(0xFF03DAC6).withValues(alpha: 0.6),
                  strokeWidth: 1.5,
                  strokeColor: Colors.white.withValues(alpha: 0.4),
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF03DAC6).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Expense line — sunset coral
            LineChartBarData(
              spots: List.generate(data.length, (i) =>
                  FlSpot(i.toDouble(), data[i]['expense'] as double)),
              isCurved: true,
              curveSmoothness: 0.35,
              barWidth: 3,
              isStrokeCapRound: true,
              gradient: const LinearGradient(
                  colors: [Color(0xFFFF5E62), Color(0xFFE57373)]),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  radius: index == _touchedIndex ? 0 : 2.5,
                  color: const Color(0xFFFF5E62).withValues(alpha: 0.6),
                  strokeWidth: 1.5,
                  strokeColor: Colors.white.withValues(alpha: 0.4),
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFF5E62).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ];

    return LineChartData(
      gridData: gridData,
      borderData: FlBorderData(show: false),
      minX: -0.3,
      maxX: (data.length - 1).toDouble() + 0.3,
      minY: minY,
      maxY: maxY,
      lineTouchData: lineTouchData,
      titlesData: titlesData,
      lineBarsData: bars,
    );
  }

  // ── Chip Widget ────────────────────────────────────────────────
  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.85)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(
            color: selected ? Colors.white : Colors.white54,
            fontSize: 10,
            fontWeight: selected ? FontWeight.bold : FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  // ── Data Methods (unchanged) ───────────────────────────────────

  List<Map<String, dynamic>> _getDailyNetWorth(
      TransactionProvider provider, double currentNetWorth) {
    final now   = DateTime.now();
    final dates = List.generate(7, (i) => now.subtract(Duration(days: 6 - i)));
    final result = <Map<String, dynamic>>[];
    final txs    = List.of(provider.transactions);

    for (int i = 6; i >= 0; i--) {
      final date      = dates[i];
      final endOfDay  = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
      final txsAfter  = txs.where((tx) => tx.date.isAfter(endOfDay));
      double delta    = 0;
      for (final tx in txsAfter) {
        delta += tx.isExpense ? -tx.amount : tx.amount;
      }
      result.insert(0, {
        'label': '${date.day}/${date.month}',
        'value': currentNetWorth - delta,
      });
    }
    return result;
  }

  List<Map<String, dynamic>> _getMonthlyNetWorth(
      TransactionProvider provider, double currentNetWorth) {
    final now    = DateTime.now();
    final months = List.generate(6, (i) {
      final month = now.month - (5 - i);
      final year  = now.year + (month <= 0 ? -1 : 0);
      return DateTime(year, month <= 0 ? month + 12 : month);
    });

    const names  = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final result = <Map<String, dynamic>>[];
    final txs    = List.of(provider.transactions);

    for (int i = 5; i >= 0; i--) {
      final ms       = months[i];
      final endOfMonth = DateTime(ms.year, ms.month + 1, 1)
          .subtract(const Duration(microseconds: 1));
      final txsAfter = txs.where((tx) => tx.date.isAfter(endOfMonth));
      double delta   = 0;
      for (final tx in txsAfter) {
        delta += tx.isExpense ? -tx.amount : tx.amount;
      }
      result.insert(0, {
        'label': names[ms.month - 1],
        'value': currentNetWorth - delta,
      });
    }
    return result;
  }

  List<Map<String, dynamic>> _getDailyCashFlow(TransactionProvider provider) {
    final now  = DateTime.now();
    return List.generate(7, (i) {
      final date   = now.subtract(Duration(days: 6 - i));
      final dayTxs = provider.transactions.where((tx) =>
          tx.date.year == date.year &&
          tx.date.month == date.month &&
          tx.date.day == date.day);
      return {
        'label':   '${date.day}/${date.month}',
        'income':  dayTxs.where((tx) => !tx.isExpense).fold(0.0, (s, tx) => s + tx.amount),
        'expense': dayTxs.where((tx) =>  tx.isExpense).fold(0.0, (s, tx) => s + tx.amount),
      };
    });
  }

  List<Map<String, dynamic>> _getMonthlyCashFlow(TransactionProvider provider) {
    final now  = DateTime.now();
    const names = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return List.generate(6, (i) {
      final month = now.month - (5 - i);
      final year  = now.year + (month <= 0 ? -1 : 0);
      final date  = DateTime(year, month <= 0 ? month + 12 : month);
      final mTxs  = provider.transactions.where(
          (tx) => tx.date.year == date.year && tx.date.month == date.month);
      return {
        'label':   names[date.month - 1],
        'income':  mTxs.where((tx) => !tx.isExpense).fold(0.0, (s, tx) => s + tx.amount),
        'expense': mTxs.where((tx) =>  tx.isExpense).fold(0.0, (s, tx) => s + tx.amount),
      };
    });
  }
}
