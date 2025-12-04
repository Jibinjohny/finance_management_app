import 'package:flutter/material.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';
import '../utils/localization_helper.dart';

class PaymentModeSelector extends StatelessWidget {
  final String selectedMode;
  final Function(String) onModeSelected;

  const PaymentModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
  });

  final List<Map<String, dynamic>> _paymentModes = const [
    {'name': 'Cash', 'icon': Icons.money},
    {'name': 'Credit Card', 'icon': Icons.credit_card},
    {'name': 'Debit Card', 'icon': Icons.credit_card},
    {'name': 'UPI', 'icon': Icons.qr_code},
    {'name': 'Net Banking', 'icon': Icons.account_balance},
    {'name': 'Other', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.paymentModeLabel,
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: _paymentModes.map((mode) {
            final isSelected = selectedMode == mode['name'];
            return GestureDetector(
              onTap: () => onModeSelected(mode['name']),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.3)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      mode['icon'],
                      size: 16,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                    SizedBox(width: 6),
                    Text(
                      LocalizationHelper.getLocalizedPaymentMode(
                        context,
                        mode['name'],
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
