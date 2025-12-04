import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class NetWorthBarChart extends StatefulWidget {
  const NetWorthBarChart({super.key});

  @override
  State<NetWorthBarChart> createState() => _NetWorthBarChartState();
}

class _NetWorthBarChartState extends State<NetWorthBarChart> {
  bool _isMonthly = false; // false = daily, true = monthly

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final data = _isMonthly
            ? _getMonthlyData(provider)
            : _getDailyData(provider);

        return Column(
          children: [
            // Bar Chart
            SizedBox(
              height: 150,
              child: data.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.noDataAvailable,
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    )
                  : BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: _getMaxY(data),
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (group) =>
                                Colors.black.withValues(alpha: 0.8),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              final label = data[groupIndex]['label'] as String;
                              final value = rod.toY;
                              final type = rodIndex == 0
                                  ? AppLocalizations.of(context)!.income
                                  : AppLocalizations.of(context)!.expense;
                              return BarTooltipItem(
                                '$label\n$type: ${CurrencyHelper.getSymbol(context)}${value.toStringAsFixed(0)}',
                                TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= data.length) {
                                  return SizedBox();
                                }
                                return Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    data[value.toInt()]['label'] as String,
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${CurrencyHelper.getSymbol(context)}${(value / 1000).toStringAsFixed(0)}k',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 10,
                                  ),
                                );
                              },
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: (_getMaxY(data) / 4).clamp(
                            1.0,
                            double.infinity,
                          ),
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.white.withValues(alpha: 0.1),
                              strokeWidth: 1,
                            );
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: data.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: item['income'] as double,
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColors.income.withValues(alpha: 0.9),
                                    AppColors.income,
                                    AppColors.income.withValues(alpha: 0.5),
                                  ],
                                  stops: const [0.0, 0.7, 1.0],
                                ),
                                width: 14,
                                borderRadius: BorderRadius.circular(30),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: _getMaxY(data),
                                  color: Colors.white.withValues(alpha: 0.02),
                                ),
                              ),
                              BarChartRodData(
                                toY: item['expense'] as double,
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColors.expense.withValues(alpha: 0.9),
                                    AppColors.expense,
                                    AppColors.expense.withValues(alpha: 0.5),
                                  ],
                                  stops: const [0.0, 0.7, 1.0],
                                ),
                                width: 14,
                                borderRadius: BorderRadius.circular(30),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: _getMaxY(data),
                                  color: Colors.white.withValues(alpha: 0.02),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
            SizedBox(height: 16),
            // Attractive Tab Bar
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  // Animated Background Indicator
                  AnimatedAlign(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment: _isMonthly
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 32,
                      height: 40,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withValues(alpha: 0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Tab Buttons
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isMonthly = false;
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: !_isMonthly
                                        ? Colors.white
                                        : Colors.white54,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    AppLocalizations.of(context)!.daily,
                                    style: TextStyle(
                                      color: !_isMonthly
                                          ? Colors.white
                                          : Colors.white54,
                                      fontSize: 13,
                                      fontWeight: !_isMonthly
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isMonthly = true;
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    size: 14,
                                    color: _isMonthly
                                        ? Colors.white
                                        : Colors.white54,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    AppLocalizations.of(context)!.monthly,
                                    style: TextStyle(
                                      color: _isMonthly
                                          ? Colors.white
                                          : Colors.white54,
                                      fontSize: 13,
                                      fontWeight: _isMonthly
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _getDailyData(TransactionProvider provider) {
    final now = DateTime.now();
    final last7Days = List.generate(
      7,
      (i) => now.subtract(Duration(days: 6 - i)),
    );

    return last7Days.map((date) {
      final dayTransactions = provider.transactions.where(
        (tx) =>
            tx.date.year == date.year &&
            tx.date.month == date.month &&
            tx.date.day == date.day,
      );

      final income = dayTransactions
          .where((tx) => !tx.isExpense)
          .fold(0.0, (sum, tx) => sum + tx.amount);

      final expense = dayTransactions
          .where((tx) => tx.isExpense)
          .fold(0.0, (sum, tx) => sum + tx.amount);

      return {
        'label': '${date.day}/${date.month}',
        'income': income,
        'expense': expense,
      };
    }).toList();
  }

  List<Map<String, dynamic>> _getMonthlyData(TransactionProvider provider) {
    final now = DateTime.now();
    final last6Months = List.generate(6, (i) {
      final month = now.month - (5 - i);
      final year = now.year + (month <= 0 ? -1 : 0);
      final adjustedMonth = month <= 0 ? month + 12 : month;
      return DateTime(year, adjustedMonth);
    });

    return last6Months.map((date) {
      final monthTransactions = provider.transactions.where(
        (tx) => tx.date.year == date.year && tx.date.month == date.month,
      );

      final income = monthTransactions
          .where((tx) => !tx.isExpense)
          .fold(0.0, (sum, tx) => sum + tx.amount);

      final expense = monthTransactions
          .where((tx) => tx.isExpense)
          .fold(0.0, (sum, tx) => sum + tx.amount);

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      return {
        'label': months[date.month - 1],
        'income': income,
        'expense': expense,
      };
    }).toList();
  }

  double _getMaxY(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return 10000;

    double max = 0;
    for (var item in data) {
      final income = item['income'] as double;
      final expense = item['expense'] as double;
      if (income > max) max = income;
      if (expense > max) max = expense;
    }

    // Ensure max is never zero to prevent division by zero errors
    if (max == 0) return 100;

    return max * 1.2; // Add 20% padding
  }
}
