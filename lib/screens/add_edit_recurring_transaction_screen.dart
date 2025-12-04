import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/recurring_transaction.dart';
import '../providers/recurring_transaction_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/account_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';
import '../widgets/income_expense_switch.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class AddEditRecurringTransactionScreen extends StatefulWidget {
  final RecurringTransaction? recurringTransaction;

  const AddEditRecurringTransactionScreen({
    super.key,
    this.recurringTransaction,
  });

  @override
  State<AddEditRecurringTransactionScreen> createState() =>
      _AddEditRecurringTransactionScreenState();
}

class _AddEditRecurringTransactionScreenState
    extends State<AddEditRecurringTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late String _category;
  late String _frequency;
  late DateTime _startDate;
  late bool _isAutoAdd;
  late bool _isExpense;
  String? _selectedAccountId;

  bool _isLoading = false;

  List<Map<String, dynamic>> _getFrequencies(BuildContext context) {
    return [
      {
        'value': 'daily',
        'label': AppLocalizations.of(context)!.frequencyDaily,
        'icon': Icons.today,
      },
      {
        'value': 'weekly',
        'label': AppLocalizations.of(context)!.frequencyWeekly,
        'icon': Icons.date_range,
      },
      {
        'value': 'monthly',
        'label': AppLocalizations.of(context)!.frequencyMonthly,
        'icon': Icons.calendar_month,
      },
      {
        'value': 'yearly',
        'label': AppLocalizations.of(context)!.frequencyYearly,
        'icon': Icons.calendar_today,
      },
    ];
  }

  final List<String> _expenseCategories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Health',
    'Education',
    'Other',
  ];

  final List<String> _incomeCategories = [
    'Salary',
    'Business',
    'Investment',
    'Gift',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    final item = widget.recurringTransaction;
    _titleController = TextEditingController(text: item?.title ?? '');
    _amountController = TextEditingController(
      text: item?.amount.toString() ?? '',
    );
    _category = item?.category ?? 'Food';
    _frequency = item?.frequency ?? 'monthly';
    _startDate = item?.nextDueDate ?? DateTime.now();
    _isAutoAdd = item?.isAutoAdd ?? true;
    _isExpense = item?.isExpense ?? true;
    _selectedAccountId = item?.accountId;

    // Ensure category is valid for type
    if (_isExpense && !_expenseCategories.contains(_category)) {
      _category = _expenseCategories.first;
    } else if (!_isExpense && !_incomeCategories.contains(_category)) {
      _category = _incomeCategories.first;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final provider = Provider.of<RecurringTransactionProvider>(
        context,
        listen: false,
      );
      final userId = authProvider.currentUser!.id;

      final amount = double.parse(_amountController.text);

      final newItem = RecurringTransaction(
        id: widget.recurringTransaction?.id ?? const Uuid().v4(),
        title: _titleController.text,
        amount: amount,
        category: _category,
        frequency: _frequency,
        nextDueDate: _startDate,
        isAutoAdd: _isAutoAdd,
        accountId: _selectedAccountId,
        userId: userId,
        isExpense: _isExpense,
      );

      if (widget.recurringTransaction != null) {
        await provider.updateRecurringTransaction(newItem);
      } else {
        await provider.addRecurringTransaction(newItem);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        GlassSnackBar.showError(
          context,
          message: AppLocalizations.of(
            context,
          )!.errorSavingRecurring(e.toString()),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    final accounts = accountProvider.accounts;

    // Set default account if not set
    if (_selectedAccountId == null && accounts.isNotEmpty) {
      _selectedAccountId = accounts.first.id;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.recurringTransaction != null
              ? AppLocalizations.of(context)!.editRecurringTitle
              : AppLocalizations.of(context)!.addRecurringTitle,
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
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(
                              context,
                            )!.transactionDetailsLabel,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),

                          // Income/Expense Toggle
                          IncomeExpenseSwitch(
                            isExpense: _isExpense,
                            onIsExpenseChanged: (isExpense) {
                              setState(() {
                                _isExpense = isExpense;
                                if (isExpense) {
                                  if (!_expenseCategories.contains(_category)) {
                                    _category = _expenseCategories.first;
                                  }
                                } else {
                                  if (!_incomeCategories.contains(_category)) {
                                    _category = _incomeCategories.first;
                                  }
                                }
                              });
                            },
                          ),
                          SizedBox(height: 8),

                          // Title
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.titleLabel,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextFormField(
                                  controller: _titleController,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(
                                      context,
                                    )!.titleHint,
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? AppLocalizations.of(
                                          context,
                                        )!.accountNameError
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          // Amount
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.amountLabel,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextFormField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(
                                      context,
                                    )!.amountHint,
                                    hintStyle: TextStyle(color: Colors.white24),
                                    prefixText:
                                        '${CurrencyHelper.getSymbol(context)} ',
                                    prefixStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return AppLocalizations.of(
                                        context,
                                      )!.enterAmountError;
                                    if (double.tryParse(value) == null)
                                      return AppLocalizations.of(
                                        context,
                                      )!.validAmountError;
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          // Category
                          Text(
                            AppLocalizations.of(context)!.categoryLabel,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children:
                                (_isExpense
                                        ? _expenseCategories
                                        : _incomeCategories)
                                    .map((cat) {
                                      final isSelected = _category == cat;
                                      return GestureDetector(
                                        onTap: () =>
                                            setState(() => _category = cat),
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColors.primary.withValues(
                                                    alpha: 0.3,
                                                  )
                                                : Colors.white.withValues(
                                                    alpha: 0.05,
                                                  ),
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : Colors.white.withValues(
                                                      alpha: 0.15,
                                                    ),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            cat,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                    .toList(),
                          ),
                          SizedBox(height: 8),

                          // Frequency
                          Text(
                            AppLocalizations.of(context)!.frequencyLabel,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 6),
                          ..._getFrequencies(context).map((freq) {
                            final isSelected = _frequency == freq['value'];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _frequency = freq['value']),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary.withValues(
                                            alpha: 0.2,
                                          )
                                        : Colors.white.withValues(alpha: 0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : Colors.white.withValues(alpha: 0.1),
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Icon(
                                          freq['icon'],
                                          color: AppColors.primary,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        freq['label'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      Spacer(),
                                      if (isSelected)
                                        Icon(
                                          Icons.check_circle,
                                          color: AppColors.primary,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          SizedBox(height: 8),

                          // Start Date
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
                                      AppLocalizations.of(
                                        context,
                                      )!.startDateLabel,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      DateFormat('MMM d, y').format(_startDate),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: _startDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
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
                                      setState(() => _startDate = picked);
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
                          SizedBox(height: 8),

                          // Account Selection
                          if (accounts.isNotEmpty) ...[
                            Text(
                              AppLocalizations.of(context)!.selectAccountLabel,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 6),
                            ...accounts.map((account) {
                              final isSelected =
                                  _selectedAccountId == account.id;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: GestureDetector(
                                  onTap: () => setState(
                                    () => _selectedAccountId = account.id,
                                  ),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary.withValues(
                                              alpha: 0.2,
                                            )
                                          : Colors.white.withValues(
                                              alpha: 0.05,
                                            ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primary
                                            : Colors.white.withValues(
                                                alpha: 0.1,
                                              ),
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.account_balance_wallet,
                                            color: AppColors.primary,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            account.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        if (isSelected)
                                          Icon(
                                            Icons.check_circle,
                                            color: AppColors.primary,
                                            size: 20,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            SizedBox(height: 8),
                          ],

                          // Auto-add Switch
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.autoAddLabel,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.autoAddSubtitle,
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Switch(
                                  value: _isAutoAdd,
                                  onChanged: (val) =>
                                      setState(() => _isAutoAdd = val),
                                  activeColor: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Fixed Buttons at Bottom
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.3),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
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
                            AppLocalizations.of(context)!.cancelButton,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            elevation: 5,
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.saveRecurringButton,
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
            ),
          ),
        ],
      ),
    );
  }
}
