import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/account_provider.dart';
import '../models/account.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/chart_widget.dart';
import '../widgets/glass_container.dart';
import '../widgets/category_pie_chart.dart';
import '../services/pdf_service.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});

  @override
  State<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen> {
  String? _selectedMonth;
  String? _selectedAccountId;
  final PdfService _pdfService = PdfService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Always visible
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.monthlyReport,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Share Button
                  Consumer2<TransactionProvider, AccountProvider>(
                    builder: (context, txProvider, accountProvider, child) {
                      return GestureDetector(
                        onTap: () async {
                          if (_selectedMonth == null) {
                            debugPrint('No month selected');
                            return;
                          }

                          debugPrint(
                            'Starting PDF generation for $_selectedMonth',
                          );

                          final income = txProvider.getIncome(
                            monthKey: _selectedMonth,
                            accountId: _selectedAccountId,
                          );
                          final expense = txProvider.getExpense(
                            monthKey: _selectedMonth,
                            accountId: _selectedAccountId,
                          );
                          final transactions = txProvider
                              .getFilteredTransactions(
                                monthKey: _selectedMonth,
                                accountId: _selectedAccountId,
                              );
                          final breakdown = txProvider.getCategoryBreakdown(
                            monthKey: _selectedMonth,
                            accountId: _selectedAccountId,
                          );

                          debugPrint(
                            'Data collected: Income=$income, Expense=$expense, Transactions=${transactions.length}',
                          );

                          // Capture currency symbol before async operation
                          final currencySymbol = CurrencyHelper.getSymbol(
                            context,
                            listen: false,
                          );

                          debugPrint('Currency symbol: $currencySymbol');

                          // Collect account names
                          final accountNames = {
                            for (var account in accountProvider.accounts)
                              account.id: account.name,
                          };

                          if (context.mounted) {
                            GlassSnackBar.showInfo(
                              context,
                              message: AppLocalizations.of(
                                context,
                              )!.generatingPdf,
                            );
                          }

                          // Collect localized labels
                          final Map<String, String> localizedLabels = {
                            'monthlyFinancialReport': AppLocalizations.of(
                              context,
                            )!.monthlyFinancialReport,
                            'generatedOn': AppLocalizations.of(
                              context,
                            )!.generatedOn('{date}'),
                            'income': AppLocalizations.of(context)!.income,
                            'expense': AppLocalizations.of(context)!.expense,
                            'netBalance': AppLocalizations.of(
                              context,
                            )!.netBalance,
                            'expenseBreakdown': AppLocalizations.of(
                              context,
                            )!.expenseBreakdown,
                            'dateHeader': AppLocalizations.of(
                              context,
                            )!.dateHeader,
                            'categoryLabel': AppLocalizations.of(
                              context,
                            )!.categoryLabel,
                            'accountBreakdown': AppLocalizations.of(
                              context,
                            )!.accountBreakdown,
                            'modeHeader': AppLocalizations.of(
                              context,
                            )!.modeHeader,
                            'descriptionHeader': AppLocalizations.of(
                              context,
                            )!.descriptionHeader,
                            'amountHeader': AppLocalizations.of(
                              context,
                            )!.amountHeader,
                          };

                          try {
                            debugPrint('Calling shareMonthlyReport...');
                            await _pdfService.shareMonthlyReport(
                              monthYear: _selectedMonth!,
                              totalIncome: income,
                              totalExpense: expense,
                              transactions: transactions,
                              categoryExpenses: breakdown,
                              currencySymbol: currencySymbol,
                              accountNames: accountNames,
                              localizedLabels: localizedLabels,
                            );
                            debugPrint('PDF shared successfully');
                          } catch (e, stackTrace) {
                            debugPrint('Error sharing PDF: $e');
                            debugPrint('Stack trace: $stackTrace');
                            if (context.mounted) {
                              GlassSnackBar.showError(
                                context,
                                message: AppLocalizations.of(
                                  context,
                                )!.errorSharingPdf(e.toString()),
                              );
                            }
                          }
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
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Consumer2<TransactionProvider, AccountProvider>(
                builder: (context, provider, accountProvider, child) {
                  final months = provider.transactionsByMonth.keys.toList();
                  if (months.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.assessment_outlined,
                            size: 80,
                            color: Colors.white30,
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.noDataAvailable,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(
                              context,
                            )!.addAccountsAndTransactions,
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Default to latest month if not selected
                  _selectedMonth ??= months.first;

                  final income = provider.getIncome(
                    monthKey: _selectedMonth,
                    accountId: _selectedAccountId,
                  );
                  final expense = provider.getExpense(
                    monthKey: _selectedMonth,
                    accountId: _selectedAccountId,
                  );
                  final breakdown = provider.getCategoryBreakdown(
                    monthKey: _selectedMonth,
                    accountId: _selectedAccountId,
                  );
                  final transactions = provider.getFilteredTransactions(
                    monthKey: _selectedMonth,
                    accountId: _selectedAccountId,
                  );

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0),
                        // Filters Row
                        Row(
                          children: [
                            // Month Selector
                            Expanded(
                              child: GlassContainer(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                borderRadius: BorderRadius.circular(15),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedMonth,
                                    dropdownColor: AppColors.surface,
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    items: months.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedMonth = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            // Account Selector
                            Expanded(
                              child: GlassContainer(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                borderRadius: BorderRadius.circular(15),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String?>(
                                    value: _selectedAccountId,
                                    dropdownColor: AppColors.surface,
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    hint: Text(
                                      AppLocalizations.of(context)!.allAccounts,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem<String?>(
                                        value: null,
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.allAccounts,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      ...accountProvider.accounts.map((
                                        account,
                                      ) {
                                        return DropdownMenuItem<String?>(
                                          value: account.id,
                                          child: Text(
                                            account.type == AccountType.bank &&
                                                    account.bankName != null
                                                ? '${account.name} (${account.bankName})'
                                                : account.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }),
                                    ],
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedAccountId = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Summary Chart
                        Text(
                          AppLocalizations.of(context)!.overview,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        GlassContainer(
                          padding: EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(15),
                          child: ChartWidget(income: income, expense: expense),
                        ),

                        SizedBox(height: 16),

                        // Totals
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSummaryCard(
                              AppLocalizations.of(context)!.income,
                              income,
                              AppColors.income,
                            ),
                            _buildSummaryCard(
                              AppLocalizations.of(context)!.expense,
                              expense,
                              AppColors.expense,
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        // Category Breakdown
                        Text(
                          AppLocalizations.of(context)!.expenseBreakdown,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),

                        if (breakdown.isNotEmpty) ...[
                          GlassContainer(
                            padding: EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(24),
                            child: CategoryPieChart(data: breakdown),
                          ),
                          SizedBox(height: 16),
                        ],

                        if (breakdown.isEmpty)
                          Text(
                            AppLocalizations.of(context)!.noExpensesForPeriod,
                            style: TextStyle(color: Colors.white54),
                          )
                        else
                          ...breakdown.entries.map((entry) {
                            final percentage = (entry.value / expense * 100)
                                .toStringAsFixed(1);
                            return GlassContainer(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.all(12),
                              borderRadius: BorderRadius.circular(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    entry.key,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '${CurrencyHelper.getSymbol(context)}${entry.value.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '$percentage%',
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),

                        SizedBox(height: 25),

                        // Transaction List
                        Text(
                          AppLocalizations.of(context)!.transactions,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        if (transactions.isEmpty)
                          Text(
                            AppLocalizations.of(context)!.noTransactionsFound,
                            style: TextStyle(color: Colors.white54),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final tx = transactions[index];
                              return GlassContainer(
                                margin: EdgeInsets.only(bottom: 8),
                                padding: EdgeInsets.all(12),
                                borderRadius: BorderRadius.circular(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tx.title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          if (tx.accountId != null)
                                            Text(
                                              accountProvider.getAccountName(
                                                tx.accountId!,
                                              ),
                                              style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 10,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${tx.isExpense ? "-" : "+"}${CurrencyHelper.getSymbol(context)}${tx.amount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: tx.isExpense
                                            ? AppColors.expense
                                            : AppColors.income,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        // Bottom Spacer for Scroll Visibility
                        SizedBox(height: 80),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color) {
    return GlassContainer(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: EdgeInsets.all(15),
      borderRadius: BorderRadius.circular(12),
      color: color.withValues(alpha: 0.1),
      borderColor: color.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: 5),
          Text(
            '${CurrencyHelper.getSymbol(context)}${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
