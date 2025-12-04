import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../models/transaction.dart' as model;
import '../providers/transaction_provider.dart';
import '../providers/account_provider.dart';
import '../providers/tag_provider.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';
import '../widgets/transaction_tile.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _filterType = 'all'; // all, income, expense
  final List<String> _selectedTagIds = [];

  void _showTagFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Consumer<TagProvider>(
        builder: (context, tagProvider, child) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: GlassContainer(
              padding: EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.filterByTags,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_selectedTagIds.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedTagIds.clear();
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.clear,
                            style: TextStyle(color: AppColors.error),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (tagProvider.tags.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.noTagsAvailable,
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    )
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tagProvider.tags.map((tag) {
                        final isSelected = _selectedTagIds.contains(tag.id);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedTagIds.remove(tag.id);
                              } else {
                                _selectedTagIds.add(tag.id);
                              }
                            });
                            Navigator.pop(context);
                            _showTagFilterDialog(context);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(tag.color).withValues(alpha: 0.3)
                                  : Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Color(tag.color)
                                    : Colors.white.withValues(alpha: 0.15),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isSelected) ...[
                                  Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                ],
                                Text(
                                  tag.name,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white70,
                                    fontSize: 12,
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
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.done,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.allTransactions,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Filter Chips
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(
                          AppLocalizations.of(context)!.all,
                          'all',
                        ),
                        SizedBox(width: 10),
                        _buildFilterChip(
                          AppLocalizations.of(context)!.income,
                          'income',
                        ),
                        SizedBox(width: 10),
                        _buildFilterChip(
                          AppLocalizations.of(context)!.expense,
                          'expense',
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _showTagFilterDialog(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedTagIds.isNotEmpty
                                  ? AppColors.primary
                                  : Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _selectedTagIds.isNotEmpty
                                    ? AppColors.primary
                                    : Colors.white24,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.label_outline,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  _selectedTagIds.isEmpty
                                      ? AppLocalizations.of(context)!.tags
                                      : '${_selectedTagIds.length} ${AppLocalizations.of(context)!.tags}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: _selectedTagIds.isNotEmpty
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Transaction List
                Expanded(
                  child:
                      Consumer3<
                        TransactionProvider,
                        AccountProvider,
                        TagProvider
                      >(
                        builder:
                            (
                              context,
                              txProvider,
                              accountProvider,
                              tagProvider,
                              child,
                            ) {
                              final transactions = _getFilteredTransactions(
                                txProvider.transactions,
                              );

                              if (transactions.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.receipt_long_outlined,
                                        size: 64,
                                        color: Colors.white24,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.noTransactionsFound,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                itemCount: transactions.length,
                                itemBuilder: (context, index) {
                                  final tx = transactions[index];
                                  final account = tx.accountId != null
                                      ? accountProvider.getAccountById(
                                          tx.accountId!,
                                        )
                                      : null;

                                  return Dismissible(
                                    key: ValueKey(tx.id),
                                    background: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.error.withValues(
                                          alpha: 0.8,
                                        ),
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
                                      return await _showDeleteConfirmation(
                                        context,
                                        tx,
                                      );
                                    },
                                    onDismissed: (direction) {
                                      txProvider.deleteTransaction(tx.id);
                                      GlassSnackBar.showSuccess(
                                        context,
                                        message: AppLocalizations.of(
                                          context,
                                        )!.transactionDeleted,
                                      );
                                    },
                                    child: TransactionTile(
                                      transaction: tx,
                                      account: account,
                                      tagProvider: tagProvider,
                                      showTags: true,
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
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filterType == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _filterType = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  List<model.Transaction> _getFilteredTransactions(
    List<model.Transaction> transactions,
  ) {
    List<model.Transaction> filtered = transactions;

    // Filter by type
    if (_filterType == 'income') {
      filtered = filtered.where((tx) => !tx.isExpense).toList();
    } else if (_filterType == 'expense') {
      filtered = filtered.where((tx) => tx.isExpense).toList();
    }

    // Filter by tags
    if (_selectedTagIds.isNotEmpty) {
      filtered = filtered.where((tx) {
        return _selectedTagIds.any((tagId) => tx.tags.contains(tagId));
      }).toList();
    }

    return filtered;
  }

  Future<bool?> _showDeleteConfirmation(
    BuildContext context,
    model.Transaction tx,
  ) async {
    return await showDialog<bool>(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: GlassContainer(
              padding: EdgeInsets.all(24),
              borderRadius: BorderRadius.circular(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete_outline, color: AppColors.error, size: 48),
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.deleteTransaction,
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
                    )!.deleteTransactionConfirmation(tx.title),
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
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
                          onPressed: () => Navigator.of(context).pop(true),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: AppColors.error,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.deleteTransaction,
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
  }
}
