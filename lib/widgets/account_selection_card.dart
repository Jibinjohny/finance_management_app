import 'package:flutter/material.dart';
import '../models/account.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import 'glass_container.dart';

class AccountSelectionCard extends StatelessWidget {
  final Account account;
  final bool isSelected;
  final VoidCallback onTap;

  const AccountSelectionCard({
    super.key,
    required this.account,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(account.color).withValues(alpha: isSelected ? 0.25 : 0.15),
            Color(account.color).withValues(alpha: isSelected ? 0.1 : 0.05),
            Colors.black.withValues(alpha: 0.2),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        borderColor: isSelected
            ? AppColors.primary
            : Color(account.color).withValues(alpha: 0.3),
        borderWidth: isSelected ? 2.0 : 1.0,
        boxShadow: [
          BoxShadow(
            color: Color(
              account.color,
            ).withValues(alpha: isSelected ? 0.2 : 0.1),
            blurRadius: 12,
            spreadRadius: -2,
            offset: Offset(0, 8),
          ),
        ],
        child: Row(
          children: [
            // Account Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(account.color).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                IconData(account.icon, fontFamily: 'MaterialIcons'),
                color: Color(account.color),
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            // Account Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    account.bankName != null
                        ? account.bankName!
                        : account.type.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            // Balance & Checkmark
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${CurrencyHelper.getSymbol(context)}${account.balance.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(height: 4),
                  Icon(Icons.check_circle, color: AppColors.primary, size: 16),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
