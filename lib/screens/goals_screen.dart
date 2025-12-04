import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/goal_provider.dart';
import '../providers/account_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import '../models/goal.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../widgets/glass_container.dart';
import '../widgets/account_dropdown_card.dart';
import '../models/account.dart';
import '../utils/glass_snackbar.dart';
import 'add_edit_goal_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<GoalProvider>(context, listen: false).fetchGoals(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Financial Goals',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                ],
              ),
            ),
          ),
          // Blobs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    blurRadius: 80,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Consumer<GoalProvider>(
              builder: (context, provider, child) {
                final goals = provider.goals;

                if (goals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flag_outlined,
                          size: 64,
                          color: Colors.white38,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No goals set yet',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return _buildGoalCard(context, goal);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditGoalScreen()),
          );
        },
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context, Goal goal) {
    final currencyFormat = NumberFormat.currency(
      symbol: CurrencyHelper.getSymbol(context),
      decimalDigits: 0,
    );
    final progress = (goal.currentAmount / goal.targetAmount).clamp(0.0, 1.0);

    return InkWell(
      onLongPress: () {
        HapticFeedback.mediumImpact();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddEditGoalScreen(goal: goal)),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: GlassContainer(
        padding: EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(goal.color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    IconData(goal.icon, fontFamily: 'MaterialIcons'),
                    color: Color(goal.color),
                    size: 24,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    goal.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(goal.color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(goal.color).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    '${(progress * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: Color(goal.color),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (progress >= 1.0) ...[
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(Color(goal.color)),
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Saved: ${currencyFormat.format(goal.currentAmount)}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: () => _showAddFundsDialog(context, goal),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(goal.color).withValues(alpha: 0.2),
                  foregroundColor: Color(goal.color),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Color(goal.color).withValues(alpha: 0.4),
                    ),
                  ),
                ),
                child: const Text(
                  'Add Funds',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddFundsDialog(BuildContext context, Goal goal) {
    final controller = TextEditingController();
    Account? selectedAccount;
    final screenContext = context; // Capture screen context for SnackBar

    showDialog(
      context: context,
      builder: (ctx) => Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: GlassContainer(
              padding: EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(20),
              child: StatefulBuilder(
                builder: (context, setState) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Add Funds to ${goal.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Account Selection
                    AccountDropdownCard(
                      selectedAccount: selectedAccount,
                      onAccountSelected: (account) {
                        setState(() {
                          selectedAccount = account;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        hintStyle: TextStyle(color: Colors.white38),
                        prefixText: '${CurrencyHelper.getSymbol(context)} ',
                        prefixStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white70),
                          ),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            final amount = double.tryParse(controller.text);

                            if (amount != null &&
                                amount > 0 &&
                                selectedAccount != null) {
                              // Check if account has sufficient balance
                              if (selectedAccount!.balance < amount) {
                                GlassSnackBar.showError(
                                  screenContext,
                                  message:
                                      'Insufficient balance in ${selectedAccount!.name}',
                                );
                                return;
                              }

                              final userId = Provider.of<AuthProvider>(
                                ctx,
                                listen: false,
                              ).currentUser?.id;

                              if (userId != null) {
                                try {
                                  await Provider.of<GoalProvider>(
                                    ctx,
                                    listen: false,
                                  ).addFunds(
                                    goal.id,
                                    amount,
                                    selectedAccount!.id,
                                    userId,
                                  );

                                  // Refresh accounts and transactions (don't await to avoid context issues)
                                  if (ctx.mounted) {
                                    Provider.of<AccountProvider>(
                                      ctx,
                                      listen: false,
                                    ).loadAccounts();
                                    Provider.of<TransactionProvider>(
                                      ctx,
                                      listen: false,
                                    ).fetchTransactions();

                                    Navigator.pop(ctx);
                                    GlassSnackBar.showSuccess(
                                      screenContext,
                                      message: 'Funds added successfully',
                                    );
                                  }
                                } catch (e) {
                                  if (ctx.mounted) {
                                    Navigator.pop(ctx);
                                    GlassSnackBar.showError(
                                      screenContext,
                                      message: 'Failed to add funds: $e',
                                    );
                                  }
                                }
                              }
                            } else {
                              if (selectedAccount == null) {
                                GlassSnackBar.showError(
                                  screenContext,
                                  message: 'Please select an account',
                                );
                              } else {
                                GlassSnackBar.showError(
                                  screenContext,
                                  message: 'Please enter a valid amount',
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
