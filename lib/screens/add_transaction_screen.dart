import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction.dart';
import '../models/account.dart';
import '../providers/transaction_provider.dart';
import '../providers/account_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';
import '../widgets/account_dropdown_card.dart';
import 'add_account_screen.dart';
import '../providers/category_provider.dart';
import '../widgets/income_expense_switch.dart';
import '../widgets/payment_mode_selector.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _amountFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _scrollController = ScrollController();
  bool _isExpense = true;
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Food';
  String _selectedPaymentMode = 'Cash';
  Account? _selectedAccount;

  final List<String> _expenseCategories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Health',
    'Other',
  ];

  final List<String> _incomeCategories = [
    'Salary',
    'Freelance',
    'Business',
    'Investment',
    'Gift',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    // Add listeners to scroll to focused field when keyboard appears
    _amountFocusNode.addListener(() {
      if (_amountFocusNode.hasFocus) {
        _scrollToField(0); // Scroll to top for amount field
      }
    });

    _titleFocusNode.addListener(() {
      if (_titleFocusNode.hasFocus) {
        _scrollToField(200); // Scroll down a bit for title field
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final accountProvider = Provider.of<AccountProvider>(
        context,
        listen: false,
      );
      if (accountProvider.accounts.isNotEmpty) {
        setState(() {
          _selectedAccount = accountProvider.accounts.first;
        });
      }
    });
  }

  void _scrollToField(double offset) {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          offset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _amountFocusNode.dispose();
    _titleFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _saveTransaction() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) {
      return;
    }

    final enteredAmount = double.tryParse(_amountController.text);
    if (enteredAmount == null || enteredAmount <= 0) {
      return;
    }

    final newTx = Transaction(
      id: const Uuid().v4(),
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate,
      isExpense: _isExpense,
      category: _selectedCategory,
      userId: '', // Provider will override this
      accountId: _selectedAccount?.id,
      paymentMode: _selectedPaymentMode,
    );

    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).addTransaction(newTx);

    // Show celebratory message for income
    if (!_isExpense) {
      final messages = [
        AppLocalizations.of(context)!.incomeMessage1,
        AppLocalizations.of(context)!.incomeMessage2,
        AppLocalizations.of(context)!.incomeMessage3,
        AppLocalizations.of(context)!.incomeMessage4,
        AppLocalizations.of(context)!.incomeMessage5,
        AppLocalizations.of(context)!.incomeMessage6,
        AppLocalizations.of(context)!.incomeMessage7,
        AppLocalizations.of(context)!.incomeMessage8,
      ];
      final randomMessage =
          messages[DateTime.now().millisecond % messages.length];

      GlassSnackBar.showSuccess(
        context,
        message: randomMessage,
        duration: Duration(seconds: 2),
      );
    }

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: AppColors.background,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.background,
            body: child!,
          ),
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      snap: true,
      snapSizes: [0.75],
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Background Blobs
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.3),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondary.withValues(alpha: 0.3),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withValues(alpha: 0.3),
                          blurRadius: 100,
                          spreadRadius: 50,
                        ),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    // Drag Handle
                    SizedBox(height: 10),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.addTransactionTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    // Form Content
                    Expanded(
                      child: Consumer<AccountProvider>(
                        builder: (context, accountProvider, child) {
                          // Check if no accounts exist
                          if (accountProvider.accounts.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.2,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.account_balance_wallet_outlined,
                                        size: 60,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(height: 24),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.noAccountsFound,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.noAccountsMessage,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 30),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Navigate to add account screen
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => AddAccountScreen(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.addAccountAction,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 32,
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        elevation: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // Normal form when accounts exist
                          return SingleChildScrollView(
                            controller: _scrollController,
                            padding: EdgeInsets.fromLTRB(
                              20,
                              20,
                              20,
                              MediaQuery.of(context).viewInsets.bottom + 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Amount Input
                                GlassContainer(
                                  padding: EdgeInsets.all(15),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.amountLabel,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextField(
                                        controller: _amountController,
                                        focusNode: _amountFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onSubmitted: (_) {
                                          _titleFocusNode.requestFocus();
                                        },
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                              decimal: true,
                                            ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                          prefixText:
                                              '${CurrencyHelper.getSymbol(context)} ',
                                          prefixStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                          ),
                                          border: InputBorder.none,
                                          hintText: AppLocalizations.of(
                                            context,
                                          )!.amountHint,
                                          hintStyle: TextStyle(
                                            color: Colors.white30,
                                          ),
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),

                                // Account Selection
                                AccountDropdownCard(
                                  selectedAccount: _selectedAccount,
                                  onAccountSelected: (account) {
                                    setState(() {
                                      _selectedAccount = account;
                                    });
                                  },
                                ),
                                SizedBox(height: 15),

                                // Transaction Type Toggle
                                IncomeExpenseSwitch(
                                  isExpense: _isExpense,
                                  onIsExpenseChanged: (isExpense) {
                                    setState(() {
                                      _isExpense = isExpense;
                                      _selectedCategory = isExpense
                                          ? _expenseCategories[0]
                                          : _incomeCategories[0];
                                    });
                                  },
                                ),
                                SizedBox(height: 15),

                                // Details Form
                                GlassContainer(
                                  padding: EdgeInsets.all(15),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _titleController,
                                        focusNode: _titleFocusNode,
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) {
                                          _titleFocusNode.unfocus();
                                        },
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: AppLocalizations.of(
                                            context,
                                          )!.titleLabel,
                                          labelStyle: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white30,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          isDense: true,
                                        ),
                                      ),
                                      SizedBox(height: 15),

                                      // Category Dropdown
                                      Consumer<CategoryProvider>(
                                        builder: (context, provider, child) {
                                          final categories = _isExpense
                                              ? provider.expenseCategories
                                              : provider.incomeCategories;

                                          // Ensure selected category is valid
                                          if (!categories.any(
                                            (c) => c.name == _selectedCategory,
                                          )) {
                                            if (categories.isNotEmpty) {
                                              _selectedCategory =
                                                  categories.first.name;
                                            }
                                          }

                                          return DropdownButtonFormField<
                                            String
                                          >(
                                            value: _selectedCategory,
                                            dropdownColor: AppColors.surface,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            decoration: InputDecoration(
                                              labelText: AppLocalizations.of(
                                                context,
                                              )!.categoryLabel,
                                              labelStyle: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white30,
                                                    ),
                                                  ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                              isDense: true,
                                            ),
                                            items: categories.map((category) {
                                              return DropdownMenuItem(
                                                value: category.name,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      IconData(
                                                        category.iconCodePoint,
                                                        fontFamily:
                                                            'MaterialIcons',
                                                      ),
                                                      color: Color(
                                                        category.colorValue,
                                                      ),
                                                      size: 18,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(category.name),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                _selectedCategory = value!;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(height: 15),

                                      // Date Picker
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${AppLocalizations.of(context)!.dateLabel}: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: _presentDatePicker,
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.chooseDate,
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),

                                      // Payment Mode Selector
                                      PaymentModeSelector(
                                        selectedMode: _selectedPaymentMode,
                                        onModeSelected: (mode) {
                                          setState(() {
                                            _selectedPaymentMode = mode;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),

                                // Save Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: _saveTransaction,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.saveTransaction,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
