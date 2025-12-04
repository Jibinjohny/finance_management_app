import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'glass_container.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class IncomeExpenseSwitch extends StatelessWidget {
  final bool isExpense;
  final ValueChanged<bool> onIsExpenseChanged;

  const IncomeExpenseSwitch({
    super.key,
    required this.isExpense,
    required this.onIsExpenseChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(4),
      borderRadius: BorderRadius.circular(15),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onIsExpenseChanged(false),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8, // Reduced height from 10
                ),
                decoration: BoxDecoration(
                  color: !isExpense ? AppColors.income : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.income,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onIsExpenseChanged(true),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8, // Reduced height from 10
                ),
                decoration: BoxDecoration(
                  color: isExpense ? AppColors.expense : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.expense,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
