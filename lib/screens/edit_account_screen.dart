import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/account.dart';
import '../providers/account_provider.dart';
import '../providers/transaction_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';
import 'dart:ui';

class EditAccountScreen extends StatefulWidget {
  final Account account;

  const EditAccountScreen({super.key, required this.account});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _balanceController;
  late TextEditingController _bankNameController;
  late TextEditingController _accountNumberController;
  late TextEditingController _loanPrincipalController;
  late TextEditingController _loanInterestRateController;
  late TextEditingController _loanTenureController;
  late TextEditingController _emiAmountController;
  late TextEditingController _emisPaidController;

  late AccountType _selectedType;
  late int _selectedColor;
  late int _selectedIcon;
  DateTime? _loanStartDate;
  int? _emiPaymentDay;

  final List<int> _colors = [
    0xFF2196F3, // Blue
    0xFF4CAF50, // Green
    0xFFFFC107, // Amber
    0xFFE91E63, // Pink
    0xFF9C27B0, // Purple
    0xFF00BCD4, // Cyan
  ];

  final List<int> _icons = [
    0xe040, // account_balance
    0xe3f8, // money_off
    0xe8e5, // savings
    0xe850, // credit_card
    0xe8d4, // work
    0xe88a, // home
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing account data
    _nameController = TextEditingController(text: widget.account.name);
    _balanceController = TextEditingController(
      text: widget.account.balance.toString(),
    );
    _bankNameController = TextEditingController(
      text: widget.account.bankName ?? '',
    );
    _accountNumberController = TextEditingController(
      text: widget.account.accountNumber ?? '',
    );
    _loanPrincipalController = TextEditingController(
      text: widget.account.loanPrincipal?.toString() ?? '',
    );
    _loanInterestRateController = TextEditingController(
      text: widget.account.loanInterestRate?.toString() ?? '',
    );
    _loanTenureController = TextEditingController(
      text: widget.account.loanTenureMonths?.toString() ?? '',
    );
    _emiAmountController = TextEditingController(
      text: widget.account.emiAmount?.toString() ?? '',
    );
    _emisPaidController = TextEditingController(
      text: widget.account.emisPaid?.toString() ?? '0',
    );

    _selectedType = widget.account.type;
    _selectedColor = widget.account.color;
    _selectedIcon = widget.account.icon;
    _loanStartDate = widget.account.loanStartDate;
    _emiPaymentDay = widget.account.emiPaymentDay;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _loanPrincipalController.dispose();
    _loanInterestRateController.dispose();
    _loanTenureController.dispose();
    _emiAmountController.dispose();
    _emisPaidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.editAccountTitle,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline, color: AppColors.error),
            onPressed: _showDeleteConfirmation,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
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
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.accountDetails,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),

                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.accountNameLabel,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.accountNameError;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),

                          // Account Type Selection
                          Text(
                            AppLocalizations.of(context)!.accountTypeLabel,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 6),
                          ..._buildAccountTypeCards(),
                          SizedBox(height: 16),

                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.currentBalanceLabel,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextFormField(
                                  controller: _balanceController,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixText:
                                        '${CurrencyHelper.getSymbol(context)} ',
                                    prefixStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.balanceError;
                                    }
                                    if (double.tryParse(value) == null) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.validNumberError;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Bank-specific fields
                          if (_selectedType == AccountType.bank ||
                              _selectedType == AccountType.savings ||
                              _selectedType == AccountType.salary ||
                              _selectedType == AccountType.current ||
                              _selectedType == AccountType.creditCard) ...[
                            SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context)!.bankDetails,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            ..._buildBankFields(),
                          ],

                          // Loan-specific fields
                          if (_selectedType == AccountType.loan) ...[
                            SizedBox(height: 16),
                            Text(
                              AppLocalizations.of(context)!.loanDetails,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            ..._buildLoanFields(),
                          ],

                          SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.appearanceLabel,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),

                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.colorLabel,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _colors.map((color) {
                                    return GestureDetector(
                                      onTap: () => setState(
                                        () => _selectedColor = color,
                                      ),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Color(color),
                                          shape: BoxShape.circle,
                                          border: _selectedColor == color
                                              ? Border.all(
                                                  color: Colors.white,
                                                  width: 2.5,
                                                )
                                              : null,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  AppLocalizations.of(context)!.iconLabel,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _icons.map((icon) {
                                    return GestureDetector(
                                      onTap: () =>
                                          setState(() => _selectedIcon = icon),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                          border: _selectedIcon == icon
                                              ? Border.all(
                                                  color: AppColors.primary,
                                                  width: 2,
                                                )
                                              : null,
                                        ),
                                        child: Icon(
                                          IconData(
                                            icon,
                                            fontFamily: 'MaterialIcons',
                                          ),
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
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
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _saveAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            elevation: 5,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.saveChangesButton,
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

  List<Widget> _buildBankFields() {
    return [
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.bankNameLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _bankNameController,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.accountNumberLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _accountNumberController,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildLoanFields() {
    return [
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.loanPrincipalLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _loanPrincipalController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                prefixText: '${CurrencyHelper.getSymbol(context)} ',
                prefixStyle: TextStyle(color: AppColors.primary, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.loanPrincipalError;
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.emisPaidLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _emisPaidController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.emisPaidError;
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.emisPendingLabel,
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              initialValue: '${widget.account.emisPending}',
              enabled: false,
              style: TextStyle(color: Colors.white54, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
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
                  AppLocalizations.of(context)!.loanStartDateLabel,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  _loanStartDate == null
                      ? AppLocalizations.of(context)!.notSelected
                      : '${_loanStartDate!.day}/${_loanStartDate!.month}/${_loanStartDate!.year}',
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
                final date = await showDatePicker(
                  context: context,
                  initialDate: _loanStartDate ?? DateTime.now(),
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
                if (date != null) {
                  setState(() => _loanStartDate = date);
                }
              },
              child: Text(
                AppLocalizations.of(context)!.changeLabel,
                style: TextStyle(color: AppColors.primary, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.emiPaymentDayLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            DropdownButtonFormField<int>(
              value: _emiPaymentDay,
              dropdownColor: AppColors.surface,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              items: List.generate(31, (index) => index + 1).map((day) {
                return DropdownMenuItem<int>(
                  value: day,
                  child: Text(AppLocalizations.of(context)!.dayLabel(day)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _emiPaymentDay = value);
              },
            ),
          ],
        ),
      ),
    ];
  }

  Future<void> _saveAccount() async {
    if (_formKey.currentState!.validate()) {
      final updatedAccount = widget.account.copyWith(
        name: _nameController.text,
        balance: double.parse(_balanceController.text),
        color: _selectedColor,
        icon: _selectedIcon,
        bankName:
            (_selectedType == AccountType.bank ||
                    _selectedType == AccountType.savings ||
                    _selectedType == AccountType.salary ||
                    _selectedType == AccountType.current ||
                    _selectedType == AccountType.creditCard) &&
                _bankNameController.text.isNotEmpty
            ? _bankNameController.text
            : null,
        accountNumber:
            (_selectedType == AccountType.bank ||
                    _selectedType == AccountType.savings ||
                    _selectedType == AccountType.salary ||
                    _selectedType == AccountType.current ||
                    _selectedType == AccountType.creditCard) &&
                _accountNumberController.text.isNotEmpty
            ? _accountNumberController.text
            : null,
        loanPrincipal: _selectedType == AccountType.loan
            ? double.tryParse(_loanPrincipalController.text)
            : null,
        loanStartDate: _selectedType == AccountType.loan
            ? _loanStartDate
            : null,
        emiPaymentDay: _selectedType == AccountType.loan
            ? _emiPaymentDay
            : null,
        emisPaid: _selectedType == AccountType.loan
            ? int.tryParse(_emisPaidController.text)
            : null,
      );

      try {
        await Provider.of<AccountProvider>(
          context,
          listen: false,
        ).updateAccount(updatedAccount);
        if (mounted) {
          Navigator.pop(context);
          GlassSnackBar.showSuccess(
            context,
            message: AppLocalizations.of(context)!.accountUpdatedSuccess,
          );
        }
      } catch (e) {
        if (mounted) {
          GlassSnackBar.showError(
            context,
            message: AppLocalizations.of(
              context,
            )!.accountUpdateError(e.toString()),
          );
        }
      }
    }
  }

  Future<void> _showDeleteConfirmation() async {
    // Check if account has transactions
    final transactionProvider = Provider.of<TransactionProvider>(
      context,
      listen: false,
    );
    final transactionCount = transactionProvider.transactions
        .where((tx) => tx.accountId == widget.account.id)
        .length;

    // Show delete confirmation with transaction info
    final confirmed = await showDialog<bool>(
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
                    AppLocalizations.of(context)!.deleteAccountTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    transactionCount > 0
                        ? AppLocalizations.of(context)!.deleteAccountWarning(
                            widget.account.name,
                            transactionCount,
                          )
                        : AppLocalizations.of(
                            context,
                          )!.deleteAccountMessage(widget.account.name),
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
                            backgroundColor: Colors.white.withValues(alpha: 0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
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
                            AppLocalizations.of(context)!.deleteButton,
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

    if (confirmed == true) {
      try {
        final deletedCount = await Provider.of<AccountProvider>(
          context,
          listen: false,
        ).deleteAccount(widget.account.id, transactionProvider);

        if (mounted) {
          Navigator.pop(context);
          String message = 'Account deleted successfully';
          if (deletedCount > 0) {
            message =
                'Account deleted along with $deletedCount transaction${deletedCount > 1 ? 's' : ''}';
          }

          GlassSnackBar.showSuccess(context, message: message);
        }
      } catch (e) {
        if (mounted) {
          GlassSnackBar.showError(
            context,
            message: 'Error deleting account: $e',
          );
        }
      }
    }
  }

  List<Widget> _buildAccountTypeCards() {
    final types = [
      {'type': AccountType.cash, 'name': 'Cash', 'icon': Icons.money},
      {'type': AccountType.savings, 'name': 'Savings', 'icon': Icons.savings},
      {'type': AccountType.salary, 'name': 'Salary', 'icon': Icons.work},
      {
        'type': AccountType.current,
        'name': 'Current',
        'icon': Icons.account_balance,
      },
      {
        'type': AccountType.creditCard,
        'name': 'Credit Card',
        'icon': Icons.credit_card,
      },
      {
        'type': AccountType.bank,
        'name': 'Bank',
        'icon': Icons.account_balance_wallet,
      },
      {
        'type': AccountType.investment,
        'name': 'Investment',
        'icon': Icons.trending_up,
      },
      {'type': AccountType.loan, 'name': 'Loan', 'icon': Icons.receipt_long},
      {'type': AccountType.other, 'name': 'Other', 'icon': Icons.more_horiz},
    ];

    return types.map((typeData) {
      final type = typeData['type'] as AccountType;
      final name = typeData['name'] as String;
      final icon = typeData['icon'] as IconData;
      final isSelected = _selectedType == type;

      return Padding(
        padding: EdgeInsets.only(bottom: 6),
        child: GestureDetector(
          onTap: () => setState(() => _selectedType = type),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.2)
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
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20),
                ),
                SizedBox(width: 12),
                Text(
                  name,
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
                  Icon(Icons.check_circle, color: AppColors.primary, size: 20),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
