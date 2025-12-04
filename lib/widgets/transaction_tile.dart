import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../models/account.dart';
import '../providers/tag_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../utils/localization_helper.dart';
import 'glass_container.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final Account? account;
  final TagProvider? tagProvider;
  final VoidCallback? onTap;
  final bool showTags;
  final bool isListItem;

  const TransactionTile({
    super.key,
    required this.transaction,
    this.account,
    this.tagProvider,
    this.onTap,
    this.showTags = false,
    this.isListItem = false,
  });

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) {
      return 'Today';
    } else if (checkDate == yesterday) {
      return 'Yesterday';
    } else {
      final months = [
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
      return '${date.day} ${months[date.month - 1]}';
    }
  }

  IconData _getPaymentIcon(String mode) {
    switch (mode) {
      case 'Credit Card':
      case 'Debit Card':
        return Icons.credit_card;
      case 'UPI':
        return Icons.qr_code;
      case 'Net Banking':
        return Icons.account_balance;
      case 'Other':
        return Icons.more_horiz;
      default:
        return Icons.money;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      children: [
        // Icon Container
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: transaction.isExpense
                ? AppColors.expense.withValues(alpha: 0.1)
                : AppColors.income.withValues(alpha: 0.1),
            border: Border.all(
              color: transaction.isExpense
                  ? AppColors.expense.withValues(alpha: 0.3)
                  : AppColors.income.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: transaction.isExpense
                    ? AppColors.expense.withValues(alpha: 0.15)
                    : AppColors.income.withValues(alpha: 0.15),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Icon(
            transaction.isExpense
                ? Icons.arrow_outward_rounded
                : Icons.arrow_downward_rounded,
            color: transaction.isExpense ? AppColors.expense : AppColors.income,
            size: 22,
          ),
        ),
        const SizedBox(width: 16),

        // Details Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                transaction.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    LocalizationHelper.getLocalizedCategoryName(
                      context,
                      transaction.category,
                    ),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (account != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        account!.name,
                        style: TextStyle(
                          color: Color(account!.color).withValues(alpha: 0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
              if (transaction.paymentMode != 'Cash') ...[
                const SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getPaymentIcon(transaction.paymentMode),
                        size: 10,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 4),
                      Text(
                        LocalizationHelper.getLocalizedPaymentMode(
                          context,
                          transaction.paymentMode,
                        ),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Amount & Date Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${transaction.isExpense ? "-" : "+"}${CurrencyHelper.getSymbol(context)}${transaction.amount.toStringAsFixed(0)}',
              style: TextStyle(
                color: transaction.isExpense
                    ? AppColors.expense
                    : AppColors.income,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(transaction.date),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );

    if (isListItem) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent, // Hit test behavior
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
          child: content,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            transaction.isExpense
                ? AppColors.expense.withValues(alpha: 0.05)
                : AppColors.income.withValues(alpha: 0.05),
            Colors.black.withValues(alpha: 0.2),
          ],
        ),
        borderColor: transaction.isExpense
            ? AppColors.expense.withValues(alpha: 0.1)
            : AppColors.income.withValues(alpha: 0.1),
        child: content,
      ),
    );
  }
}
