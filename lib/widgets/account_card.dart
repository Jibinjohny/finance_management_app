import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/account.dart';
import '../widgets/glass_container.dart';
import '../screens/edit_account_screen.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final bool allowEdit;
  final VoidCallback? onTap;

  const AccountCard({
    super.key,
    required this.account,
    this.onTap,
    this.allowEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: allowEdit
          ? () {
              HapticFeedback.mediumImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAccountScreen(account: account),
                ),
              );
            }
          : null,
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(account.color).withValues(alpha: 0.15),
            Color(account.color).withValues(alpha: 0.05),
            Colors.black.withValues(alpha: 0.2),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderColor: Color(account.color).withValues(alpha: 0.3),
        boxShadow: [
          BoxShadow(
            color: Color(account.color).withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: -5,
            offset: Offset(0, 10),
          ),
        ],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(account.color).withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          IconData(account.icon, fontFamily: 'MaterialIcons'),
                          color: Color(account.color),
                          size: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          account.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  // Show bank name and number as subtitles if available
                  if (account.bankName != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      account.bankName!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (account.accountNumber != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'A/C: ${account.accountNumber}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${CurrencyHelper.getSymbol(context)}${account.balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (account.type == AccountType.loan) ...[
                    const SizedBox(height: 6),
                    // Only show EMI and Tenure for compact view
                    Row(
                      children: [
                        if (account.emiAmount != null)
                          Expanded(
                            child: Text(
                              'EMI: ${CurrencyHelper.getSymbol(context)}${account.emiAmount!.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        if (account.emisPaid != null &&
                            account.loanTenureMonths != null)
                          Expanded(
                            child: Text(
                              'Paid: ${account.emisPaid}/${account.loanTenureMonths} m',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  Consumer<TransactionProvider>(
                    builder: (context, provider, child) {
                      final income = provider.getAccountIncome(account.id);
                      final expense = provider.getAccountExpense(account.id);

                      return Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: AppColors.income,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${CurrencyHelper.getSymbol(context)}${income.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        color: AppColors.income,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: AppColors.expense,
                                  size: 16,
                                ),
                                SizedBox(width: 4),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${CurrencyHelper.getSymbol(context)}${expense.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        color: AppColors.expense,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            // Right Column: Type Label + Chart
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  margin: const EdgeInsets.only(bottom: 12, left: 16),
                  decoration: BoxDecoration(
                    color: Color(account.color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    account.type.toString().split('.').last.toUpperCase(),
                    style: TextStyle(
                      color: Color(account.color),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Consumer<TransactionProvider>(
                  builder: (context, provider, child) {
                    final income = provider.getAccountIncome(account.id);
                    final expense = provider.getAccountExpense(account.id);
                    return Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(left: 16),
                      child: CustomPaint(
                        painter: _RingChartPainter(
                          income: income,
                          expense: expense,
                          incomeColor: AppColors.income,
                          expenseColor: AppColors.expense,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.pie_chart_outline,
                            color: Colors.white24,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RingChartPainter extends CustomPainter {
  final double income;
  final double expense;
  final Color incomeColor;
  final Color expenseColor;

  _RingChartPainter({
    required this.income,
    required this.expense,
    required this.incomeColor,
    required this.expenseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 6.0;
    final rect = Rect.fromCircle(
      center: center,
      radius: radius - strokeWidth / 2,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final total = income + expense;
    if (total == 0) {
      paint.color = Colors.white10;
      canvas.drawArc(rect, 0, 2 * 3.14159, false, paint);
      return;
    }

    // Draw Income Arc
    if (income > 0) {
      paint.color = incomeColor;
      final sweepAngle = (income / total) * 2 * 3.14159;
      canvas.drawArc(rect, -3.14159 / 2, sweepAngle, false, paint);
    }

    // Draw Expense Arc
    if (expense > 0) {
      paint.color = expenseColor;
      // Start where income ended
      final startAngle = -3.14159 / 2 + (income / total) * 2 * 3.14159;
      final sweepAngle = (expense / total) * 2 * 3.14159;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
