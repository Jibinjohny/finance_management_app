import 'dart:ui';
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
import '../widgets/liquid_glass_fab.dart';
import 'add_edit_goal_screen.dart';

import '../widgets/apple_liquid_glass_app_bar.dart';

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
      appBar: const AppleLiquidGlassAppBar(title: 'Financial Goals'),
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
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 195,
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
      floatingActionButton: LiquidGlassFAB(
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
        padding: const EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Color(goal.color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    IconData(goal.icon, fontFamily: 'MaterialIcons'),
                    color: Color(goal.color),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    goal.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
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
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (progress >= 1.0) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 14),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(Color(goal.color)),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Saved: ${currencyFormat.format(goal.currentAmount)}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 34,
              child: ElevatedButton(
                onPressed: () => _showAddFundsDialog(context, goal),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(goal.color).withValues(alpha: 0.2),
                  foregroundColor: Color(goal.color),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Color(goal.color).withValues(alpha: 0.4),
                    ),
                  ),
                ),
                child: const Text(
                  'Add Funds',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
    final screenContext = context;
    final goalColor = Color(goal.color);

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (ctx) => Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              child: GlassContainer(
                padding: const EdgeInsets.all(0),
                borderRadius: BorderRadius.circular(24),
                child: StatefulBuilder(
                  builder: (context, setState) => ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Coloured header ──────────────────────────────
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                goalColor.withValues(alpha: 0.30),
                                goalColor.withValues(alpha: 0.12),
                              ],
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: goalColor.withValues(alpha: 0.25),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: goalColor.withValues(alpha: 0.20),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: goalColor.withValues(alpha: 0.35),
                                  ),
                                ),
                                child: Icon(
                                  IconData(goal.icon, fontFamily: 'MaterialIcons'),
                                  color: goalColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Add Funds',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      goal.name,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.65),
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ── Body ────────────────────────────────────────
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Account picker
                              AccountDropdownCard(
                                selectedAccount: selectedAccount,
                                onAccountSelected: (account) {
                                  setState(() => selectedAccount = account);
                                },
                              ),
                              const SizedBox(height: 14),

                              // Amount input — glass-styled container
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.14),
                                  ),
                                ),
                                child: TextField(
                                  controller: controller,
                                  keyboardType: const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '0.00',
                                    hintStyle: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.3),
                                      fontSize: 16,
                                    ),
                                    prefixText:
                                        '${CurrencyHelper.getSymbol(context)}  ',
                                    prefixStyle: TextStyle(
                                      color: goalColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Buttons row
                              Row(
                                children: [
                                  // Cancel — ghost pill
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          side: BorderSide(
                                            color: Colors.white.withValues(alpha: 0.18),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Add — liquid-glass primary
                                  Expanded(
                                    flex: 2,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                          colors: [
                                            goalColor.withValues(alpha: 0.85),
                                            goalColor.withValues(alpha: 0.55),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: goalColor.withValues(alpha: 0.40),
                                            blurRadius: 12,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: 0.22),
                                        ),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () async {
                                          final amount = double.tryParse(
                                            controller.text,
                                          );

                                          if (amount != null &&
                                              amount > 0 &&
                                              selectedAccount != null) {
                                            if (selectedAccount!.balance < amount) {
                                              GlassSnackBar.showError(
                                                screenContext,
                                                message:
                                                    'Insufficient balance in ${selectedAccount!.name}',
                                              );
                                              return;
                                            }

                                            final userId =
                                                Provider.of<AuthProvider>(
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
                                                    message:
                                                        'Funds added successfully',
                                                  );
                                                }
                                              } catch (e) {
                                                if (ctx.mounted) {
                                                  Navigator.pop(ctx);
                                                  GlassSnackBar.showError(
                                                    screenContext,
                                                    message:
                                                        'Failed to add funds: $e',
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
                                                message:
                                                    'Please enter a valid amount',
                                              );
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'Add Funds',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
