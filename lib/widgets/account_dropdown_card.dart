import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/account.dart';
import '../providers/account_provider.dart';
import '../utils/app_colors.dart';
import 'account_selection_card.dart';
import 'glass_container.dart';

class AccountDropdownCard extends StatelessWidget {
  final Account? selectedAccount;
  final Function(Account) onAccountSelected;
  final String label;

  final bool showAllAccountsOption;

  const AccountDropdownCard({
    super.key,
    required this.selectedAccount,
    required this.onAccountSelected,
    this.label = 'Select Account',
    this.showAllAccountsOption = false,
  });

  void _showAccountSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Color(0xFF1A1A2E).withValues(alpha: 0.95),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              border: Border(
                top: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
              ),
            ),
            child: Column(
              children: [
                // Handle
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 12, bottom: 20),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Select Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                // List
                Expanded(
                  child: Consumer<AccountProvider>(
                    builder: (context, provider, child) {
                      if (provider.accounts.isEmpty && !showAllAccountsOption) {
                        return Center(
                          child: Text(
                            'No accounts available',
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }
                      return ListView(
                        controller: scrollController,
                        padding: EdgeInsets.all(20),
                        children: [
                          if (showAllAccountsOption)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  onAccountSelected(
                                    Account(
                                      id: 'all',
                                      name: 'All Accounts',
                                      type: AccountType.cash,
                                      balance: 0,
                                      color: 0xFF9E9E9E, // Grey color
                                      icon: Icons
                                          .account_balance_wallet
                                          .codePoint,
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                                child: GlassContainer(
                                  padding: const EdgeInsets.all(16),
                                  borderRadius: BorderRadius.circular(24),
                                  borderColor: selectedAccount == null
                                      ? AppColors.primary
                                      : Colors.white.withValues(alpha: 0.1),
                                  borderWidth: selectedAccount == null
                                      ? 2.0
                                      : 1.0,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.all_inclusive,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        'All Accounts',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      if (selectedAccount == null)
                                        Icon(
                                          Icons.check_circle,
                                          color: AppColors.primary,
                                          size: 16,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ...provider.accounts.map((account) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: AccountSelectionCard(
                                account: account,
                                isSelected: selectedAccount?.id == account.id,
                                onTap: () {
                                  onAccountSelected(account);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (selectedAccount == null) {
      return GestureDetector(
        onTap: () => _showAccountSelectionSheet(context),
        child: GlassContainer(
          padding: EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
              SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Spacer(),
              Icon(Icons.keyboard_arrow_down, color: Colors.white54),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _showAccountSelectionSheet(context),
      child: AccountSelectionCard(
        account: selectedAccount!,
        isSelected: true, // Always show as selected/active style
        onTap: () => _showAccountSelectionSheet(context),
      ),
    );
  }
}
