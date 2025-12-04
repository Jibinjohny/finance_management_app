import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class ChartWidget extends StatelessWidget {
  final double income;
  final double expense;

  const ChartWidget({super.key, required this.income, required this.expense});

  @override
  Widget build(BuildContext context) {
    final total = income + expense;
    final incomePercentage = total == 0 ? 0.0 : (income / total) * 100;
    final expensePercentage = total == 0 ? 0.0 : (expense / total) * 100;

    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 5, // Space between sections
              centerSpaceRadius: 35, // Larger hole for donut effect
              startDegreeOffset: 270,
              sections: [
                PieChartSectionData(
                  color: AppColors.income,
                  value: incomePercentage,
                  title: '', // No text on chart
                  radius: 12, // Thinner ring
                  showTitle: false,
                  badgeWidget: null,
                ),
                PieChartSectionData(
                  color: AppColors.expense,
                  value: expensePercentage,
                  title: '',
                  radius: 12,
                  showTitle: false,
                  badgeWidget: null,
                ),
              ],
            ),
          ),
          // Center Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.balance,
                style: TextStyle(color: Colors.white54, fontSize: 10),
              ),
              Text(
                '${(incomePercentage - expensePercentage).abs().toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
