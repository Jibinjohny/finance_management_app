import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/account_provider.dart';
import '../providers/goal_provider.dart';

import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../widgets/chart_widget.dart';
import '../widgets/glass_container.dart';
import '../widgets/account_card.dart';
import '../widgets/net_worth_bar_chart.dart';
import '../widgets/transaction_tile.dart';
import 'notifications_screen.dart';
import 'transactions_screen.dart';
import 'profile_screen.dart';
import '../providers/notification_provider.dart';
import 'budgets_screen.dart';
import '../providers/recurring_transaction_provider.dart';
import 'recurring_transactions_screen.dart';
import 'goals_screen.dart';
import 'calendar_screen.dart';
import 'insights_screen.dart';
import 'tags_management_screen.dart';
import 'categories_screen.dart';

import 'package:animations/animations.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isNetWorthVisible = true;

  @override
  void initState() {
    super.initState();
    _loadNetWorthVisibility();
    Future.microtask(() {
      Provider.of<AccountProvider>(context, listen: false).loadAccounts();
      Provider.of<TransactionProvider>(
        context,
        listen: false,
      ).fetchTransactions();
      Provider.of<RecurringTransactionProvider>(
        context,
        listen: false,
      ).checkAndProcessDueTransactions();
      final userId = Provider.of<AuthProvider>(
        context,
        listen: false,
      ).currentUser?.id;
      if (userId != null) {
        Provider.of<NotificationProvider>(
          context,
          listen: false,
        ).loadNotifications(userId);
      }
    });
  }

  Future<void> _loadNetWorthVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNetWorthVisible = prefs.getBool('netWorthVisible') ?? true;
    });
  }

  Future<void> _toggleNetWorthVisibility() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNetWorthVisible = !_isNetWorthVisible;
    });
    await prefs.setBool('netWorthVisible', _isNetWorthVisible);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Scrollable Content
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Header (scrollable with content)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Consumer<AuthProvider>(
                              builder: (context, auth, child) {
                                return Text(
                                  '${AppLocalizations.of(context)!.hello}, ${auth.currentUser?.firstName ?? "User"}!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                );
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!.welcomeBack,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          // Notifications Icon
                          Consumer<NotificationProvider>(
                            builder: (context, notifProvider, child) {
                              return Stack(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.notifications_outlined),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => NotificationsScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  if (notifProvider.unreadCount > 0)
                                    Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: AppColors.error,
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Text(
                                          '${notifProvider.unreadCount}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          // Profile Icon with special styling
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProfileScreen(),
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
                                    color: AppColors.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // 1. Net Worth Card
                  GlassContainer(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.primary.withValues(alpha: 0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.netWorth,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: _toggleNetWorthVisibility,
                              child: Icon(
                                _isNetWorthVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.white70,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Consumer2<AccountProvider, GoalProvider>(
                          builder: (context, accountProvider, goalProvider, child) {
                            final totalNetWorth =
                                accountProvider.totalNetWorth +
                                goalProvider.totalGoalAmount;
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                _isNetWorthVisible
                                    ? '${CurrencyHelper.getSymbol(context)}${totalNetWorth.toStringAsFixed(2)}'
                                    : '${CurrencyHelper.getSymbol(context)}••••••',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 12),
                        // Bar Chart with Day/Month Toggle
                        NetWorthBarChart(),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // 2. Financial Planning Section
                  Text(
                    AppLocalizations.of(context)!.financialPlanning,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 110,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      children: [
                        _buildFeatureCard(
                          context,
                          AppLocalizations.of(context)!.budgets,
                          Icons.eco_rounded, // Leaf icon
                          Colors.greenAccent,
                          const BudgetsScreen(),
                        ),
                        SizedBox(width: 16),
                        _buildFeatureCard(
                          context,
                          AppLocalizations.of(context)!.goals,
                          Icons.star_rounded, // Star icon
                          Colors.blueAccent,
                          const GoalsScreen(),
                        ),
                        SizedBox(width: 16),
                        _buildFeatureCard(
                          context,
                          AppLocalizations.of(context)!.categories,
                          Icons.category_rounded,
                          Colors.orangeAccent,
                          const CategoriesScreen(),
                        ),
                        SizedBox(width: 16),
                        _buildFeatureCard(
                          context,
                          AppLocalizations.of(context)!.recurring,
                          Icons.access_time_filled_rounded, // Clock icon
                          Colors.amberAccent,
                          const RecurringTransactionsScreen(),
                        ),
                        SizedBox(width: 16),
                        _buildFeatureCard(
                          context,
                          AppLocalizations.of(context)!.calendar,
                          Icons.calendar_month_rounded,
                          Colors.pinkAccent,
                          const CalendarScreen(),
                        ),
                        SizedBox(width: 16),
                        _buildFeatureCard(
                          context,
                          AppLocalizations.of(context)!.insights,
                          Icons.lightbulb_rounded,
                          Colors.purpleAccent,
                          const InsightsScreen(),
                        ),
                        SizedBox(width: 16),
                        _buildFeatureCard(
                          context,
                          AppLocalizations.of(context)!.tags,
                          Icons.label_rounded,
                          Colors.tealAccent,
                          const TagsManagementScreen(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // 3. My Accounts Section
                  Text(
                    AppLocalizations.of(context)!.myAccounts,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Consumer<AccountProvider>(
                    builder: (context, provider, child) {
                      if (provider.accounts.isEmpty) {
                        return SizedBox(
                          height: 180,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.noAccountsYet,
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        );
                      }

                      return SizedBox(
                        height: 180,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.accounts.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              width: 300,
                              child: AccountCard(
                                account: provider.accounts[index],
                                onTap: () {},
                                allowEdit: false,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12),

                  // 4. Overview Section (2 Columns)
                  Text(
                    AppLocalizations.of(context)!.overview,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column 1: Chart
                      Expanded(
                        flex: 4,
                        child: Consumer<TransactionProvider>(
                          builder: (context, provider, child) {
                            return GlassContainer(
                              padding: EdgeInsets.all(20),
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.primary.withValues(alpha: 0.15),
                                  Colors.black.withValues(alpha: 0.3),
                                ],
                              ),
                              borderColor: AppColors.primary.withValues(
                                alpha: 0.2,
                              ),
                              child: Column(
                                children: [
                                  ChartWidget(
                                    income: provider.totalIncome,
                                    expense: provider.totalExpense,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 15),

                      // Column 2: Top 5 Expenses
                      Expanded(
                        flex: 5,
                        child: GlassContainer(
                          padding: EdgeInsets.all(20),
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.expense.withValues(alpha: 0.15),
                              Colors.black.withValues(alpha: 0.3),
                            ],
                          ),
                          borderColor: AppColors.expense.withValues(alpha: 0.2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.topExpenses,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Consumer<TransactionProvider>(
                                builder: (context, provider, child) {
                                  final topExpenses = provider.topExpenses;
                                  if (topExpenses.isEmpty) {
                                    return Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.noExpensesYet,
                                      style: TextStyle(
                                        color: Colors.white30,
                                        fontSize: 12,
                                      ),
                                    );
                                  }
                                  return Column(
                                    children: topExpenses.entries.map((entry) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 6.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                entry.key,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              '${CurrencyHelper.getSymbol(context)}${entry.value.toStringAsFixed(0)}',
                                              style: TextStyle(
                                                color: AppColors.expense,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Recent Transactions Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.recentTransactions,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TransactionsScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.viewAll,
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Recent Transactions List
                  Consumer2<TransactionProvider, AccountProvider>(
                    builder:
                        (context, transactionProvider, accountProvider, _) {
                          final recentTransactions =
                              transactionProvider.recentTransactions;

                          if (recentTransactions.isEmpty) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(
                                  context,
                                )!.noRecentTransactions,
                                style: TextStyle(color: Colors.white54),
                              ),
                            );
                          }

                          return GlassContainer(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 0,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withValues(alpha: 0.1),
                                Colors.white.withValues(alpha: 0.05),
                                Colors.black.withValues(alpha: 0.2),
                              ],
                            ),
                            borderColor: Colors.white.withValues(alpha: 0.15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 20,
                                spreadRadius: -5,
                                offset: Offset(0, 10),
                              ),
                            ],
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: recentTransactions.length,
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.white.withValues(alpha: 0.1),
                                height: 1,
                              ),
                              itemBuilder: (context, index) {
                                final tx = recentTransactions[index];
                                final account = tx.accountId != null
                                    ? accountProvider.getAccountById(
                                        tx.accountId!,
                                      )
                                    : null;
                                return TransactionTile(
                                  transaction: tx,
                                  account: account,
                                  isListItem: true,
                                  onTap: () {
                                    // Handle tap
                                  },
                                );
                              },
                            ),
                          );
                        },
                  ),
                  SizedBox(height: 100), // Bottom padding for FAB
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget destination,
  ) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (BuildContext context, VoidCallback _) {
        return destination;
      },
      closedElevation: 0,
      openElevation: 0,
      closedColor: Colors.transparent,
      openColor: AppColors.background,
      middleColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 500),
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: Column(
            children: [
              GlassContainer(
                width: 75,
                height: 75,
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withValues(alpha: 0.25),
                    color.withValues(alpha: 0.05),
                  ],
                ),
                borderColor: color.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.15),
                    blurRadius: 15,
                    spreadRadius: -2,
                    offset: Offset(0, 8),
                  ),
                ],
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withValues(alpha: 0.2),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.4),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 26),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
