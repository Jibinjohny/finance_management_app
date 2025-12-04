import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class FinancialTrendChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const FinancialTrendChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noDataAvailable,
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    double maxY = 0;
    for (var item in data) {
      if (item['income'] > maxY) maxY = item['income'];
      if (item['expense'] > maxY) maxY = item['expense'];
    }
    // Add some buffer to top
    maxY = maxY * 1.2;
    if (maxY == 0) maxY = 100;

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white.withValues(alpha: 0.05),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < data.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        data[index]['month'],
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: maxY / 5,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value == 0) return const SizedBox.shrink();
                  return Text(
                    _formatCompact(value),
                    style: const TextStyle(color: Colors.white54, fontSize: 10),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (data.length - 1).toDouble(),
          minY: 0,
          maxY: maxY,
          lineBarsData: [
            // Income Line
            LineChartBarData(
              spots: List.generate(data.length, (index) {
                return FlSpot(
                  index.toDouble(),
                  (data[index]['income'] as double),
                );
              }),
              isCurved: true,
              color: AppColors.income,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.income.withValues(alpha: 0.1),
              ),
            ),
            // Expense Line
            LineChartBarData(
              spots: List.generate(data.length, (index) {
                return FlSpot(
                  index.toDouble(),
                  (data[index]['expense'] as double),
                );
              }),
              isCurved: true,
              color: AppColors.expense,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.expense.withValues(alpha: 0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => AppColors.surface,
              tooltipPadding: const EdgeInsets.all(8),
              tooltipBorder: BorderSide(color: Colors.white24),
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final isIncome = barSpot.barIndex == 0;
                  final color = isIncome ? AppColors.income : AppColors.expense;
                  final label = isIncome
                      ? AppLocalizations.of(context)!.income
                      : AppLocalizations.of(context)!.expense;
                  return LineTooltipItem(
                    '$label\n${barSpot.y.toStringAsFixed(0)}',
                    TextStyle(color: color, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  String _formatCompact(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toStringAsFixed(0);
  }
}
