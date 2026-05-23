import 'package:flutter/material.dart';
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
  bool _isMonthly = false; // false = 7D (Daily), true = 6M (Monthly)
  bool _isNetWorthMode = true; // true = Cumulative Net Worth, false = Cash Flow (Income vs Expense)

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final goalProvider = Provider.of<GoalProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);

    // Calculate current live total net worth: accounts balance + goal investments
    final currentTotalNetWorth = accountProvider.totalNetWorth + goalProvider.totalGoalAmount;

    // Process our historical cumulative or flow data
    final List<Map<String, dynamic>> historicalData = _isNetWorthMode
        ? (_isMonthly
            ? _getMonthlyNetWorth(transactionProvider, currentTotalNetWorth)
            : _getDailyNetWorth(transactionProvider, currentTotalNetWorth))
        : (_isMonthly
            ? _getMonthlyCashFlow(transactionProvider)
            : _getDailyCashFlow(transactionProvider));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Beautiful, Inline Premium Glass Filter Chips
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Mode Selector: Balance (Net Worth) vs Cash Flow
            Row(
              children: [
                _buildCompactChip(
                  label: AppLocalizations.of(context)!.netWorth,
                  isSelected: _isNetWorthMode,
                  onTap: () => setState(() => _isNetWorthMode = true),
                ),
                const SizedBox(width: 8),
                _buildCompactChip(
                  label: "Cash Flow",
                  isSelected: !_isNetWorthMode,
                  onTap: () => setState(() => _isNetWorthMode = false),
                ),
              ],
            ),

            // Right Range Selector: 7D vs 6M
            Row(
              children: [
                _buildCompactChip(
                  label: "7D",
                  isSelected: !_isMonthly,
                  onTap: () => setState(() => _isMonthly = false),
                ),
                const SizedBox(width: 8),
                _buildCompactChip(
                  label: "6M",
                  isSelected: _isMonthly,
                  onTap: () => setState(() => _isMonthly = true),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // The animated, premium line chart
        SizedBox(
          height: 180,
          child: historicalData.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noDataAvailable,
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                )
              : LineChart(
                  _buildChartData(historicalData, context),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                ),
        ),
      ],
    );
  }

  // ----------------------------------------------------
  // Compact Glassmorphic Chip Builder
  // ----------------------------------------------------
  Widget _buildCompactChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.8)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    spreadRadius: 0,
                  )
                ]
              : null,
        ),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(
            color: isSelected ? Colors.white : Colors.white60,
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------
  // Dynamic Math & Seeding Calculations
  // ----------------------------------------------------

  List<Map<String, dynamic>> _getDailyNetWorth(
    TransactionProvider provider,
    double currentNetWorth,
  ) {
    final now = DateTime.now();
    final dates = List.generate(7, (i) => now.subtract(Duration(days: 6 - i)));
    final result = <Map<String, dynamic>>[];
    final txs = List.of(provider.transactions);

    for (int i = 6; i >= 0; i--) {
      final date = dates[i];
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

      // Extract total transactions net effect that occurred AFTER this day's end
      final txsAfter = txs.where((tx) => tx.date.isAfter(endOfDay));
      double deltaAfter = 0;
      for (var tx in txsAfter) {
        deltaAfter += tx.isExpense ? -tx.amount : tx.amount;
      }

      result.insert(0, {
        'label': '${date.day}/${date.month}',
        'value': currentNetWorth - deltaAfter,
      });
    }
    return result;
  }

  List<Map<String, dynamic>> _getMonthlyNetWorth(
    TransactionProvider provider,
    double currentNetWorth,
  ) {
    final now = DateTime.now();
    final months = List.generate(6, (i) {
      final month = now.month - (5 - i);
      final year = now.year + (month <= 0 ? -1 : 0);
      final adjustedMonth = month <= 0 ? month + 12 : month;
      return DateTime(year, adjustedMonth);
    });

    final result = <Map<String, dynamic>>[];
    final txs = List.of(provider.transactions);

    const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    for (int i = 5; i >= 0; i--) {
      final monthStart = months[i];
      final nextMonth = DateTime(monthStart.year, monthStart.month + 1, 1);
      final endOfMonth = nextMonth.subtract(const Duration(microseconds: 1));

      // Extract transactions that occurred AFTER this month's end
      final txsAfter = txs.where((tx) => tx.date.isAfter(endOfMonth));
      double deltaAfter = 0;
      for (var tx in txsAfter) {
        deltaAfter += tx.isExpense ? -tx.amount : tx.amount;
      }

      result.insert(0, {
        'label': monthNames[monthStart.month - 1],
        'value': currentNetWorth - deltaAfter,
      });
    }
    return result;
  }

  List<Map<String, dynamic>> _getDailyCashFlow(TransactionProvider provider) {
    final now = DateTime.now();
    final last7Days = List.generate(7, (i) => now.subtract(Duration(days: 6 - i)));

    return last7Days.map((date) {
      final dayTxs = provider.transactions.where(
        (tx) => tx.date.year == date.year && tx.date.month == date.month && tx.date.day == date.day,
      );

      final income = dayTxs.where((tx) => !tx.isExpense).fold(0.0, (sum, tx) => sum + tx.amount);
      final expense = dayTxs.where((tx) => tx.isExpense).fold(0.0, (sum, tx) => sum + tx.amount);

      return {
        'label': '${date.day}/${date.month}',
        'income': income,
        'expense': expense,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _getMonthlyCashFlow(TransactionProvider provider) {
    final now = DateTime.now();
    final last6Months = List.generate(6, (i) {
      final month = now.month - (5 - i);
      final year = now.year + (month <= 0 ? -1 : 0);
      final adjustedMonth = month <= 0 ? month + 12 : month;
      return DateTime(year, adjustedMonth);
    });

    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return last6Months.map((date) {
      final monthTxs = provider.transactions.where(
        (tx) => tx.date.year == date.year && tx.date.month == date.month,
      );

      final income = monthTxs.where((tx) => !tx.isExpense).fold(0.0, (sum, tx) => sum + tx.amount);
      final expense = monthTxs.where((tx) => tx.isExpense).fold(0.0, (sum, tx) => sum + tx.amount);

      return {
        'label': months[date.month - 1],
        'income': income,
        'expense': expense,
      };
    }).toList();
  }

  // ----------------------------------------------------
  // fl_chart Styling & Configuration
  // ----------------------------------------------------

  LineChartData _buildChartData(List<Map<String, dynamic>> data, BuildContext context) {
    // 1. Determine local bounds
    double minVal = double.infinity;
    double maxVal = -double.infinity;

    if (_isNetWorthMode) {
      for (var item in data) {
        final val = item['value'] as double;
        if (val < minVal) minVal = val;
        if (val > maxVal) maxVal = val;
      }
    } else {
      for (var item in data) {
        final inc = item['income'] as double;
        final exp = item['expense'] as double;
        if (inc < minVal) minVal = inc;
        if (exp < minVal) minVal = exp;
        if (inc > maxVal) maxVal = inc;
        if (exp > maxVal) maxVal = exp;
      }
    }

    if (minVal == double.infinity) minVal = 0;
    if (maxVal == -double.infinity) maxVal = 1000;

    // Pad top and bottom for smooth bounds rendering (floating look)
    double range = maxVal - minVal;
    if (range == 0) range = 100;
    final minY = (minVal - range * 0.15).clamp(0.0, double.infinity);
    final maxY = maxVal + range * 0.15;

    // 2. Growth metrics for Dynamic Premium HSL styling
    final bool isGrowth = _isNetWorthMode &&
        data.length > 1 &&
        (data.last['value'] as double) >= (data.first['value'] as double);

    // Custom Glassmorphic: Jade Teal for Credits vs Sunset Coral for Debits
    final accentColor = isGrowth ? const Color(0xFF03DAC6) : const Color(0xFFFF5E62); // secondary Teal vs Neon Coral
    final glowColor = isGrowth ? const Color(0xFF81C784) : const Color(0xFFE57373); // success Green vs Softer Red

    return LineChartData(
      gridData: const FlGridData(show: false), // Clean floating look
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (data.length - 1).toDouble(),
      minY: minY,
      maxY: maxY,

      // Interactive Touch bead and guide line
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: (barData.gradient?.colors.first ?? accentColor).withValues(alpha: 0.15),
                strokeWidth: 1.5,
                dashArray: [5, 5],
              ),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 6,
                    color: barData.gradient?.colors.first ?? accentColor,
                    strokeWidth: 2.5,
                    strokeColor: Colors.white,
                  );
                },
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => const Color(0xFF0F1016).withValues(alpha: 0.95),
          tooltipBorder: BorderSide(
            color: Colors.white.withValues(alpha: 0.12),
            width: 1.2,
          ),
          tooltipPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              final val = spot.y;
              final index = spot.x.toInt();
              final label = data[index]['label'] as String;
              
              String type = "";
              Color color = Colors.white;

              if (_isNetWorthMode) {
                type = AppLocalizations.of(context)!.netWorth;
                color = accentColor;
              } else {
                type = spot.barIndex == 0
                    ? AppLocalizations.of(context)!.income
                    : AppLocalizations.of(context)!.expense;
                color = spot.barIndex == 0 ? const Color(0xFF00F2FE) : const Color(0xFFFF5E62);
              }

              return LineTooltipItem(
                '$label\n',
                GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: '$type: ${CurrencyHelper.getSymbol(context)}${val.toStringAsFixed(0)}',
                    style: GoogleFonts.outfit(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),

      // Custom Axis labels (Removing left titles for clean look)
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)), // Floating curve look
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= data.length) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  data[index]['label'] as String,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.35),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),

      // Render curves with neon filament styling (no dots)
      lineBarsData: _isNetWorthMode
          ? [
              // Net Worth Line Curve
              LineChartBarData(
                spots: List.generate(data.length, (idx) {
                  return FlSpot(idx.toDouble(), data[idx]['value'] as double);
                }),
                isCurved: true,
                barWidth: 4,
                isStrokeCapRound: true,
                gradient: LinearGradient(colors: [accentColor, glowColor]),
                dotData: const FlDotData(show: false), // Clean Bezier filament
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      accentColor.withValues(alpha: 0.18),
                      glowColor.withValues(alpha: 0.04),
                      glowColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ]
          : [
              // Cash Flow Income Line (Jade Teal for Credits)
              LineChartBarData(
                spots: List.generate(data.length, (idx) {
                  return FlSpot(idx.toDouble(), data[idx]['income'] as double);
                }),
                isCurved: true,
                barWidth: 3.5,
                isStrokeCapRound: true,
                gradient: const LinearGradient(colors: [Color(0xFF03DAC6), Color(0xFF81C784)]),
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF03DAC6).withValues(alpha: 0.12),
                      const Color(0xFF03DAC6).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              // Cash Flow Expense Line (Sunset Coral for Debits)
              LineChartBarData(
                spots: List.generate(data.length, (idx) {
                  return FlSpot(idx.toDouble(), data[idx]['expense'] as double);
                }),
                isCurved: true,
                barWidth: 3.5,
                isStrokeCapRound: true,
                gradient: const LinearGradient(colors: [Color(0xFFFF5E62), Color(0xFFE57373)]),
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFFF5E62).withValues(alpha: 0.12),
                      const Color(0xFFFF5E62).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ],
    );
  }

}
