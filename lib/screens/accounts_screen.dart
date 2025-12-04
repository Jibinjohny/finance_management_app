import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/account_provider.dart';
import '../providers/transaction_provider.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/account_card.dart';
import 'dart:ui';
import '../widgets/glass_container.dart';
import 'add_account_screen.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<AccountProvider>(context, listen: false).loadAccounts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.accounts,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddAccountScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.3),
                            AppColors.secondary.withValues(alpha: 0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<AccountProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (provider.accounts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 80,
                            color: Colors.white30,
                          ),
                          SizedBox(height: 0),
                          Text(
                            AppLocalizations.of(context)!.noAccountsYet,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.addFirstAccount,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 100),
                    itemCount: provider.accounts.length,
                    itemBuilder: (context, index) {
                      final account = provider.accounts[index];
                      return Dismissible(
                        key: ValueKey(account.id),
                        background: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            barrierColor: Colors.black54,
                            builder: (BuildContext context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Dialog(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  child: GlassContainer(
                                    padding: EdgeInsets.all(24),
                                    borderRadius: BorderRadius.circular(24),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.delete_outline,
                                          color: AppColors.error,
                                          size: 48,
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.deleteAccountTitle,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.deleteAccountMessage(account.name),
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 24),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () => Navigator.of(
                                                  context,
                                                ).pop(false),
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                                  backgroundColor: Colors.white
                                                      .withValues(alpha: 0.1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.cancelButton,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () => Navigator.of(
                                                  context,
                                                ).pop(true),
                                                style: TextButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                                  backgroundColor:
                                                      AppColors.error,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.deleteButton,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        onDismissed: (direction) async {
                          final transactionProvider =
                              Provider.of<TransactionProvider>(
                                context,
                                listen: false,
                              );

                          final deletedCount = await provider.deleteAccount(
                            account.id,
                            transactionProvider,
                          );

                          String message = AppLocalizations.of(
                            context,
                          )!.accountDeleted;
                          if (deletedCount > 0) {
                            message = AppLocalizations.of(context)!
                                .accountDeletedWithTransactions(
                                  deletedCount,
                                  deletedCount > 1 ? 's' : '',
                                );
                          }

                          if (context.mounted) {
                            GlassSnackBar.showSuccess(
                              context,
                              message: message,
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: AccountCard(account: account),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
