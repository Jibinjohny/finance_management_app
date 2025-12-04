import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/account.dart';
import '../providers/account_provider.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../utils/currency_helper.dart';
import '../widgets/glass_container.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  // Bank-specific controllers
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();

  // Loan-specific controllers
  final _loanPrincipalController = TextEditingController();
  final _loanInterestRateController = TextEditingController();
  final _loanTenureController = TextEditingController();
  final _emiAmountController = TextEditingController();

  AccountType _selectedType = AccountType.cash;
  int _selectedColor = 0xFF2196F3; // Blue
  int _selectedIcon = 0xe040; // account_balance
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
  Widget build(BuildContext context) {
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
          AppLocalizations.of(context)!.addAccountTitle,
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
                            AppLocalizations.of(context)!.accountDetails,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),

                          // Account Name
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
                                    hintText: AppLocalizations.of(
                                      context,
                                    )!.accountNameHint,
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border: InputBorder.none,
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
                          SizedBox(height: 8),

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
                          SizedBox(height: 8),

                          // Initial Balance
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedType == AccountType.loan
                                      ? AppLocalizations.of(
                                          context,
                                        )!.currentBalanceLabel
                                      : _selectedType == AccountType.creditCard
                                      ? AppLocalizations.of(
                                          context,
                                        )!.creditLimitLabel
                                      : AppLocalizations.of(
                                          context,
                                        )!.initialBalanceLabel,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextFormField(
                                  controller: _balanceController,
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
                                    )!.balanceHint,
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
                          if (_selectedType == AccountType.savings ||
                              _selectedType == AccountType.salary ||
                              _selectedType == AccountType.current ||
                              _selectedType == AccountType.creditCard ||
                              _selectedType == AccountType.bank) ...[
                            SizedBox(height: 12),
                            Text(
                              _selectedType == AccountType.creditCard
                                  ? AppLocalizations.of(context)!.cardDetails
                                  : AppLocalizations.of(context)!.bankDetails,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            ..._buildBankFields(),
                          ],

                          // Loan-specific fields
                          if (_selectedType == AccountType.loan) ...[
                            SizedBox(height: 12),
                            Text(
                              AppLocalizations.of(context)!.loanDetails,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            ..._buildLoanFields(),
                          ],

                          SizedBox(height: 12),
                          Text(
                            AppLocalizations.of(context)!.appearanceLabel,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
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
                                          color: Colors.white.withValues(
                                            alpha: 0.1,
                                          ),
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
                            AppLocalizations.of(context)!.createAccountButton,
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

  List<Widget> _buildAccountTypeCards() {
    final types = [
      {
        'type': AccountType.cash,
        'name': AppLocalizations.of(context)!.accountTypeCash,
        'icon': Icons.money,
      },
      {
        'type': AccountType.savings,
        'name': AppLocalizations.of(context)!.accountTypeSavings,
        'icon': Icons.savings,
      },
      {
        'type': AccountType.salary,
        'name': AppLocalizations.of(context)!.accountTypeSalary,
        'icon': Icons.work,
      },
      {
        'type': AccountType.current,
        'name': AppLocalizations.of(context)!.accountTypeCurrent,
        'icon': Icons.account_balance,
      },
      {
        'type': AccountType.creditCard,
        'name': AppLocalizations.of(context)!.accountTypeCreditCard,
        'icon': Icons.credit_card,
      },
      {
        'type': AccountType.bank,
        'name': AppLocalizations.of(context)!.accountTypeBank,
        'icon': Icons.account_balance_wallet,
      },
      {
        'type': AccountType.investment,
        'name': AppLocalizations.of(context)!.accountTypeInvestment,
        'icon': Icons.trending_up,
      },
      {
        'type': AccountType.loan,
        'name': AppLocalizations.of(context)!.accountTypeLoan,
        'icon': Icons.receipt_long,
      },
      {
        'type': AccountType.other,
        'name': AppLocalizations.of(context)!.accountTypeOther,
        'icon': Icons.more_horiz,
      },
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

  List<Widget> _buildBankFields() {
    return [
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedType == AccountType.creditCard
                  ? AppLocalizations.of(context)!.cardIssuerLabel
                  : AppLocalizations.of(context)!.bankNameLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _bankNameController,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.bankNameHint,
                hintStyle: TextStyle(color: Colors.white38),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return _selectedType == AccountType.creditCard
                      ? AppLocalizations.of(context)!.cardIssuerError
                      : AppLocalizations.of(context)!.bankNameError;
                }
                return null;
              },
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedType == AccountType.creditCard
                  ? AppLocalizations.of(context)!.cardNumberLabel
                  : AppLocalizations.of(context)!.accountNumberLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _accountNumberController,
              keyboardType: _selectedType == AccountType.creditCard
                  ? TextInputType.number
                  : TextInputType.text,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: _selectedType == AccountType.creditCard
                    ? AppLocalizations.of(context)!.cardNumberHint
                    : AppLocalizations.of(context)!.accountNumberHint,
                hintStyle: TextStyle(color: Colors.white38),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (_selectedType == AccountType.creditCard) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.cardNumberError;
                  }
                  if (value.length != 4) {
                    return AppLocalizations.of(context)!.cardNumberLengthError;
                  }
                }
                return null;
              },
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildLoanFields() {
    return [
      // Principal Amount
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
                hintText: '0.00',
                hintStyle: TextStyle(color: Colors.white38),
                prefixText: '${CurrencyHelper.getSymbol(context)} ',
                prefixStyle: TextStyle(color: AppColors.primary, fontSize: 14),
                border: InputBorder.none,
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
      SizedBox(height: 8),
      // Interest Rate
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.interestRateLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _loanInterestRateController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: '0.0',
                hintStyle: TextStyle(color: Colors.white38),
                suffixText: '%',
                suffixStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.interestRateError;
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
      SizedBox(height: 8),
      // Tenure
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.loanTenureLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _loanTenureController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: '12',
                hintStyle: TextStyle(color: Colors.white38),
                suffixText: 'months',
                suffixStyle: TextStyle(color: Colors.white70, fontSize: 12),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.loanTenureError;
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
      SizedBox(height: 8),
      // EMI Amount
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.emiAmountLabel,
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _emiAmountController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(color: Colors.white38),
                prefixText: '${CurrencyHelper.getSymbol(context)} ',
                prefixStyle: TextStyle(color: AppColors.primary, fontSize: 14),
                border: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.emiAmountError;
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
      SizedBox(height: 8),
      // Loan Start Date
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
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
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
                AppLocalizations.of(context)!.selectLabel,
                style: TextStyle(color: AppColors.primary, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      // EMI Payment Day
      GlassContainer(
        padding: EdgeInsets.all(12),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EMI Payment Day of Month',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(height: 4),
            DropdownButtonFormField<int>(
              value: _emiPaymentDay,
              dropdownColor: AppColors.surface,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              hint: Text(
                'Select day',
                style: TextStyle(color: Colors.white38, fontSize: 14),
              ),
              items: List.generate(31, (index) => index + 1).map((day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text('$day${_getDaySuffix(day)} of every month'),
                );
              }).toList(),
              onChanged: (value) => setState(() => _emiPaymentDay = value),
              validator: (value) {
                if (value == null) {
                  return 'Please select EMI payment day';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    ];
  }

  Future<void> _saveAccount() async {
    if (_formKey.currentState!.validate()) {
      final account = Account(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        type: _selectedType,
        balance: double.parse(_balanceController.text),
        color: _selectedColor,
        icon: _selectedIcon,
        bankName:
            (_selectedType == AccountType.savings ||
                _selectedType == AccountType.salary ||
                _selectedType == AccountType.current ||
                _selectedType == AccountType.creditCard ||
                _selectedType == AccountType.bank)
            ? _bankNameController.text.isNotEmpty
                  ? _bankNameController.text
                  : null
            : null,
        accountNumber:
            (_selectedType == AccountType.savings ||
                _selectedType == AccountType.salary ||
                _selectedType == AccountType.current ||
                _selectedType == AccountType.creditCard ||
                _selectedType == AccountType.bank)
            ? _accountNumberController.text.isNotEmpty
                  ? _accountNumberController.text
                  : null
            : null,
        loanPrincipal: _selectedType == AccountType.loan
            ? double.tryParse(_loanPrincipalController.text)
            : null,
        loanInterestRate: _selectedType == AccountType.loan
            ? double.tryParse(_loanInterestRateController.text)
            : null,
        loanTenureMonths: _selectedType == AccountType.loan
            ? int.tryParse(_loanTenureController.text)
            : null,
        loanStartDate: _selectedType == AccountType.loan
            ? _loanStartDate
            : null,
        emiAmount: _selectedType == AccountType.loan
            ? double.tryParse(_emiAmountController.text)
            : null,
        emisPaid: 0,
        emiPaymentDay: _selectedType == AccountType.loan
            ? _emiPaymentDay
            : null,
      );

      try {
        await Provider.of<AccountProvider>(
          context,
          listen: false,
        ).addAccount(account);
        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          GlassSnackBar.showError(
            context,
            message: 'Error creating account: $e',
          );
        }
      }
    }
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
