import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/account.dart';
import '../providers/account_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import 'glass_container.dart';

class AccountSelectionSheet extends StatelessWidget {
  final Function(Account) onAccountSelected;

  const AccountSelectionSheet({super.key, required this.onAccountSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Select Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Consumer<AccountProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (provider.accounts.isEmpty) {
                return Center(
                  child: Text(
                    'No accounts found',
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                itemCount: provider.accounts.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final account = provider.accounts[index];
                  return GestureDetector(
                    onTap: () {
                      onAccountSelected(account);
                      Navigator.pop(context);
                    },
                    child: GlassContainer(
                      padding: EdgeInsets.all(15),
                      borderRadius: BorderRadius.circular(15),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(
                                account.color,
                              ).withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              IconData(
                                account.icon,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Color(account.color),
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  account.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2),
                                if (account.bankName != null) ...[
                                  Text(
                                    account.bankName!,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 1),
                                ] else ...[
                                  Text(
                                    account.type
                                        .toString()
                                        .split('.')
                                        .last
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 1),
                                ],
                                if (account.accountNumber != null)
                                  Text(
                                    'A/C: ${account.accountNumber}',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 11,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            '${CurrencyHelper.getSymbol(context)}${account.balance.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
