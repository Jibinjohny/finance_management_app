import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction.dart';
import '../models/account.dart';
import '../providers/transaction_provider.dart';
import '../providers/account_provider.dart';
import '../providers/tag_provider.dart';
import '../providers/category_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../utils/localization_helper.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';
import '../widgets/income_expense_switch.dart';
import '../widgets/payment_mode_selector.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class AddTransactionScreenMultiStep extends StatefulWidget {
  const AddTransactionScreenMultiStep({super.key});

  @override
  State<AddTransactionScreenMultiStep> createState() =>
      _AddTransactionScreenMultiStepState();
}

class _AddTransactionScreenMultiStepState
    extends State<AddTransactionScreenMultiStep> {
  final _pageController = PageController();
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _amountFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();

  int _currentStep = 0;
  bool _isExpense = true;
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Food';
  String _selectedPaymentMode = 'Cash';
  Account? _selectedAccount;
  final List<String> _selectedTagIds = [];

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

      Provider.of<TagProvider>(context, listen: false).fetchTags();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _amountController.dispose();
    _titleController.dispose();
    _amountFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_amountController.text.isEmpty) {
      GlassSnackBar.show(
        context,
        message: AppLocalizations.of(context)!.enterAmountError,
      );
      return;
    }

    final enteredAmount = double.tryParse(_amountController.text);
    if (enteredAmount == null || enteredAmount <= 0) {
      GlassSnackBar.show(
        context,
        message: AppLocalizations.of(context)!.validAmountError,
      );
      return;
    }

    setState(() => _currentStep = 1);
    _pageController.animateToPage(
      1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousStep() {
    setState(() => _currentStep = 0);
    _pageController.animateToPage(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _saveTransaction() {
    if (_selectedAccount == null) {
      GlassSnackBar.show(
        context,
        message: AppLocalizations.of(context)!.selectAccountError,
      );
      return;
    }

    final newTx = Transaction(
      id: const Uuid().v4(),
      title: _titleController.text.isEmpty
          ? _selectedCategory
          : _titleController.text,
      amount: double.parse(_amountController.text),
      category: _selectedCategory,
      date: _selectedDate,
      isExpense: _isExpense,
      accountId: _selectedAccount!.id,
      userId: '',
      tags: _selectedTagIds,
      paymentMode: _selectedPaymentMode,
    );

    Provider.of<TransactionProvider>(
      context,
      listen: false,
    ).addTransaction(newTx);

    GlassSnackBar.showSuccess(
      context,
      message: AppLocalizations.of(context)!.transactionAddedSuccess,
      duration: Duration(seconds: 2),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            if (_currentStep > 0) {
              _previousStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.addTransactionTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
          SafeArea(
            child: Column(
              children: [
                // Progress Indicator - Compact
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildProgressDot(0),
                      _buildProgressLine(0),
                      _buildProgressDot(1),
                    ],
                  ),
                ),

                // Steps
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [_buildStep1(), _buildStep2()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDot(int step) {
    final isActive = step == _currentStep;
    final isCompleted = step < _currentStep;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted || isActive
            ? AppColors.primary
            : Colors.white.withValues(alpha: 0.15),
        border: Border.all(
          color: isActive
              ? AppColors.primary
              : Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Center(
        child: isCompleted
            ? Icon(Icons.check, color: Colors.white, size: 12)
            : Text(
                '${step + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
      ),
    );
  }

  Widget _buildProgressLine(int step) {
    final isCompleted = step < _currentStep;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 40,
      height: 1.5,
      color: isCompleted
          ? AppColors.primary
          : Colors.white.withValues(alpha: 0.15),
    );
  }

  // STEP 1: Amount, Type, Title, Category
  Widget _buildStep1() {
    return Column(
      children: [
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.step1Title,
                  style: TextStyle(color: Colors.white54, fontSize: 10),
                ),
                SizedBox(height: 2),
                Text(
                  AppLocalizations.of(context)!.step1Subtitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),

                // Amount Input
                GlassContainer(
                  padding: EdgeInsets.all(12),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.amountLabel,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      TextField(
                        controller: _amountController,
                        focusNode: _amountFocusNode,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.amountHint,
                          hintStyle: TextStyle(color: Colors.white24),
                          prefixText: '${CurrencyHelper.getSymbol(context)} ',
                          prefixStyle: TextStyle(
                            color: AppColors.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Income/Expense Toggle
                IncomeExpenseSwitch(
                  isExpense: _isExpense,
                  onIsExpenseChanged: (isExpense) {
                    setState(() {
                      _isExpense = isExpense;
                      _selectedCategory = isExpense
                          ? _expenseCategories.first
                          : _incomeCategories.first;
                    });
                  },
                ),
                SizedBox(height: 20),

                // Title
                GlassContainer(
                  padding: EdgeInsets.all(12),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.titleOptionalLabel,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      SizedBox(height: 4),
                      TextField(
                        controller: _titleController,
                        focusNode: _titleFocusNode,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.titleHint,
                          hintStyle: TextStyle(color: Colors.white38),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Category
                Text(
                  AppLocalizations.of(context)!.categoryLabel,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 12),
                Consumer<CategoryProvider>(
                  builder: (context, provider, child) {
                    final categories = _isExpense
                        ? provider.expenseCategories
                        : provider.incomeCategories;

                    // Ensure selected category is valid
                    if (!categories.any((c) => c.name == _selectedCategory)) {
                      if (categories.isNotEmpty) {
                        // Use post frame callback to avoid setState during build
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            setState(() {
                              _selectedCategory = categories.first.name;
                            });
                          }
                        });
                      }
                    }

                    return Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: categories.map((category) {
                        final isSelected = _selectedCategory == category.name;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = category.name),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.3)
                                  : Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.white.withValues(alpha: 0.15),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  IconData(
                                    category.iconCodePoint,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: isSelected
                                      ? Colors.white
                                      : Color(category.colorValue),
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  LocalizationHelper.getLocalizedCategoryName(
                                    context,
                                    category.name,
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Fixed Buttons at Bottom
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.3),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.backButton,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.nextButton,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STEP 2: Date, Account, Tags, Summary
  Widget _buildStep2() {
    return Column(
      children: [
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.step2Title,
                  style: TextStyle(color: Colors.white54, fontSize: 10),
                ),
                SizedBox(height: 2),
                Text(
                  AppLocalizations.of(context)!.step2Subtitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),

                // Date Picker
                GlassContainer(
                  padding: EdgeInsets.all(12),
                  borderRadius: BorderRadius.circular(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dateLabel,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.dark(
                                    primary: AppColors.primary,
                                    surface: AppColors.surface,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() => _selectedDate = picked);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.changeLabel,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Account Selection - Improved with Details
                Consumer<AccountProvider>(
                  builder: (context, accountProvider, child) {
                    if (accountProvider.accounts.isEmpty) {
                      return GlassContainer(
                        padding: EdgeInsets.all(12),
                        borderRadius: BorderRadius.circular(14),
                        child: Text(
                          AppLocalizations.of(context)!.noAccountsAvailable,
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.selectAccountLabel,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(height: 12),
                        ...accountProvider.accounts.map((account) {
                          final isSelected = _selectedAccount?.id == account.id;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedAccount = account),
                              child: GlassContainer(
                                padding: const EdgeInsets.all(16),
                                borderRadius: BorderRadius.circular(24),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(account.color).withValues(
                                      alpha: isSelected ? 0.25 : 0.15,
                                    ),
                                    Color(account.color).withValues(
                                      alpha: isSelected ? 0.1 : 0.05,
                                    ),
                                    Colors.black.withValues(alpha: 0.2),
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                                borderColor: isSelected
                                    ? AppColors.primary
                                    : Color(
                                        account.color,
                                      ).withValues(alpha: 0.3),
                                borderWidth: isSelected ? 2.0 : 1.0,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(
                                      account.color,
                                    ).withValues(alpha: isSelected ? 0.2 : 0.1),
                                    blurRadius: 12,
                                    spreadRadius: -2,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                                child: Row(
                                  children: [
                                    // Account Icon
                                    Container(
                                      padding: const EdgeInsets.all(10),
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
                                    SizedBox(width: 16),
                                    // Account Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            account.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            account.bankName != null
                                                ? account.bankName!
                                                : account.type.name
                                                      .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white54,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Balance & Checkmark
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${CurrencyHelper.getSymbol(context)}${account.balance.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (isSelected) ...[
                                          SizedBox(height: 4),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.selectedLabel,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),

                // Payment Mode Selector
                GlassContainer(
                  padding: EdgeInsets.all(12),
                  borderRadius: BorderRadius.circular(14),
                  child: PaymentModeSelector(
                    selectedMode: _selectedPaymentMode,
                    onModeSelected: (mode) {
                      setState(() {
                        _selectedPaymentMode = mode;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Tags Selection
                Consumer<TagProvider>(
                  builder: (context, tagProvider, child) {
                    if (tagProvider.tags.isEmpty) {
                      return SizedBox.shrink();
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.tagsOptionalLabel,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
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
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),

                // Summary Card
                GlassContainer(
                  padding: EdgeInsets.all(12),
                  borderRadius: BorderRadius.circular(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.summaryLabel,
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      _buildSummaryRow(
                        AppLocalizations.of(context)!.amountLabel,
                        '₹${_amountController.text}',
                        _isExpense ? AppColors.expense : AppColors.income,
                      ),
                      Divider(color: Colors.white10, height: 16),
                      _buildSummaryRow(
                        AppLocalizations.of(context)!.typeLabel,
                        _isExpense
                            ? AppLocalizations.of(context)!.expense
                            : AppLocalizations.of(context)!.income,
                        Colors.white70,
                      ),
                      Divider(color: Colors.white10, height: 16),
                      _buildSummaryRow(
                        AppLocalizations.of(context)!.categoryLabel,
                        LocalizationHelper.getLocalizedCategoryName(
                          context,
                          _selectedCategory,
                        ),
                        Colors.white70,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Fixed Buttons at Bottom
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.3),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text(
                        AppLocalizations.of(context)!.backButton,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: _saveTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    elevation: 5,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.saveTransaction,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.white54, fontSize: 12)),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
