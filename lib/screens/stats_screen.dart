import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../providers/transaction_provider.dart';
import '../providers/account_provider.dart';
import '../providers/tag_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../widgets/glass_container.dart';
import '../widgets/chart_widget.dart';
import '../widgets/financial_trend_chart.dart';
import '../models/account.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  String? _selectedAccountId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Consumer3<TransactionProvider, AccountProvider, TagProvider>(
          builder: (context, txProvider, accountProvider, tagProvider, child) {
            final income = txProvider.getIncome(accountId: _selectedAccountId);
            final expense = txProvider.getExpense(
              accountId: _selectedAccountId,
            );
            final balance = income - expense;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.statistics,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 16),
                      // Account Filter Dropdown
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String?>(
                            value: _selectedAccountId,
                            dropdownColor: AppColors.surface,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            hint: Text(
                              'All Accounts',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            items: [
                              DropdownMenuItem<String?>(
                                value: null,
                                child: Text(
                                  AppLocalizations.of(context)!.allAccounts,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ...accountProvider.accounts.map((account) {
                                return DropdownMenuItem<String?>(
                                  value: account.id,
                                  child: Text(
                                    account.type == AccountType.bank &&
                                            account.bankName != null
                                        ? '${account.name} (${account.bankName})'
                                        : account.name,
                                    style: TextStyle(color: Colors.white),
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
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0),

                        // Chart Section
                        GlassContainer(
                          padding: EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.incomeVsExpense,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 15),
                              ChartWidget(income: income, expense: expense),
                            ],
                          ),
                        ),

                        SizedBox(height: 12),

                        // Financial Trend
                        GlassContainer(
                          padding: EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.financialTrend,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 15),
                              FinancialTrendChart(
                                data: txProvider.getLast6MonthsData(
                                  accountId: _selectedAccountId,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        // Detailed Stats
                        GlassContainer(
                          padding: EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            children: [
                              _buildStatRow(
                                AppLocalizations.of(context)!.totalIncome,
                                income,
                                AppColors.income,
                                Icons.arrow_downward,
                              ),
                              Divider(color: Colors.white10, height: 20),
                              _buildStatRow(
                                AppLocalizations.of(context)!.totalExpense,
                                expense,
                                AppColors.expense,
                                Icons.arrow_upward,
                              ),
                              Divider(color: Colors.white10, height: 20),
                              _buildStatRow(
                                AppLocalizations.of(context)!.totalBalance,
                                balance,
                                balance >= 0
                                    ? AppColors.income
                                    : AppColors.expense,
                                Icons.account_balance_wallet,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        SizedBox(height: 16),

                        // Tag Spending Breakdown
                        if (txProvider
                            .getTagSpendingBreakdown(
                              accountId: _selectedAccountId,
                            )
                            .isNotEmpty) ...[
                          Text(
                            AppLocalizations.of(context)!.spendingByTags,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          GlassContainer(
                            padding: EdgeInsets.all(15),
                            borderRadius: BorderRadius.circular(24),
                            child: Column(
                              children: txProvider
                                  .getTagSpendingBreakdown(
                                    accountId: _selectedAccountId,
                                  )
                                  .entries
                                  .map((entry) {
                                    final tag = tagProvider.getTagById(
                                      entry.key,
                                    );
                                    if (tag == null) return SizedBox.shrink();
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Color(
                                                tag.color,
                                              ).withValues(alpha: 0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.label,
                                              color: Color(tag.color),
                                              size: 16,
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              tag.name,
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                '${CurrencyHelper.getSymbol(context)}${entry.value.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],

                        // Account Breakdown (Only show if "All Accounts" is selected)
                        if (_selectedAccountId == null) ...[
                          Text(
                            AppLocalizations.of(context)!.accountBreakdown,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),

                          if (accountProvider.accounts.isEmpty)
                            Text(
                              AppLocalizations.of(context)!.noAccountsFound,
                              style: TextStyle(color: Colors.white54),
                            )
                          else
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: accountProvider.accounts.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final account = accountProvider.accounts[index];
                                final accountIncome = txProvider.getIncome(
                                  accountId: account.id,
                                );
                                final accountExpense = txProvider.getExpense(
                                  accountId: account.id,
                                );

                                return GlassContainer(
                                  padding: EdgeInsets.all(15),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          // Icon
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
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(width: 15),

                                          // Details
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  account.type ==
                                                              AccountType
                                                                  .bank &&
                                                          account.bankName !=
                                                              null
                                                      ? account.name
                                                      : account.name,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                if (account.type ==
                                                        AccountType.bank &&
                                                    account.bankName != null)
                                                  Text(
                                                    account.bankName!,
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                SizedBox(height: 4),
                                                Text(
                                                  '${CurrencyHelper.getSymbol(context)}${account.balance.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 12),
                                      Divider(color: Colors.white10, height: 1),
                                      SizedBox(height: 12),

                                      // Income, Expense and Chart Row
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Income
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_downward,
                                                      color: AppColors.income,
                                                      size: 14,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.income,
                                                      style: TextStyle(
                                                        color: Colors.white60,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  '${CurrencyHelper.getSymbol(context)}${accountIncome.toStringAsFixed(0)}',
                                                  style: TextStyle(
                                                    color: AppColors.income,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(width: 12),

                                          // Expense
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_upward,
                                                      color: AppColors.expense,
                                                      size: 14,
                                                    ),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.expense,
                                                      style: TextStyle(
                                                        color: Colors.white60,
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  '${CurrencyHelper.getSymbol(context)}${accountExpense.toStringAsFixed(0)}',
                                                  style: TextStyle(
                                                    color: AppColors.expense,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),

                                          SizedBox(width: 12),

                                          // Line Chart
                                          SizedBox(
                                            width: 100,
                                            height: 50,
                                            child: _AccountTrendChart(
                                              data: txProvider
                                                  .getLast6MonthsData(
                                                    accountId: account.id,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                        ],

                        // Bottom padding for navigation bar
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    double amount,
    Color color,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${CurrencyHelper.getSymbol(context)}${amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AccountTrendChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const _AccountTrendChart({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return SizedBox.shrink();

    // Calculate min and max for Y axis to scale the chart properly
    double maxY = 0;
    for (var item in data) {
      if (item['income'] > maxY) maxY = item['income'];
      if (item['expense'] > maxY) maxY = item['expense'];
    }
    // Add some padding to the top
    maxY = maxY * 1.2;
    if (maxY == 0) maxY = 100; // Default range if no data

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (data.length - 1).toDouble(),
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          // Income Line
          LineChartBarData(
            spots: List.generate(data.length, (index) {
              return FlSpot(index.toDouble(), data[index]['income']);
            }),
            isCurved: true,
            color: AppColors.income,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.income.withValues(alpha: 0.1),
            ),
          ),
          // Expense Line
          LineChartBarData(
            spots: List.generate(data.length, (index) {
              return FlSpot(index.toDouble(), data[index]['expense']);
            }),
            isCurved: true,
            color: AppColors.expense,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.expense.withValues(alpha: 0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(enabled: false),
      ),
    );
  }
}
