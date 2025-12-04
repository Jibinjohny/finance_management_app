import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/budget.dart';
import '../providers/budget_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';

class AddEditBudgetScreen extends StatefulWidget {
  final Budget? budget;

  const AddEditBudgetScreen({super.key, this.budget});

  @override
  State<AddEditBudgetScreen> createState() => _AddEditBudgetScreenState();
}

class _AddEditBudgetScreenState extends State<AddEditBudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  String _selectedCategory = 'Food';
  String _selectedPeriod = 'monthly';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Food', 'icon': Icons.restaurant},
    {'name': 'Transport', 'icon': Icons.directions_car},
    {'name': 'Shopping', 'icon': Icons.shopping_bag},
    {'name': 'Entertainment', 'icon': Icons.movie},
    {'name': 'Bills', 'icon': Icons.receipt_long},
    {'name': 'Health', 'icon': Icons.medical_services},
    {'name': 'Education', 'icon': Icons.school},
    {'name': 'Travel', 'icon': Icons.flight},
    {'name': 'Other', 'icon': Icons.more_horiz},
  ];

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.budget?.amount.toString() ?? '',
    );
    if (widget.budget != null) {
      _selectedCategory = widget.budget!.category;
      _selectedPeriod = widget.budget!.period;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _saveBudget() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final budgetProvider = Provider.of<BudgetProvider>(
        context,
        listen: false,
      );
      final userId = authProvider.currentUser!.id;

      final amount = double.parse(_amountController.text);

      if (widget.budget == null) {
        final newBudget = Budget(
          id: const Uuid().v4(),
          category: _selectedCategory,
          amount: amount,
          period: _selectedPeriod,
          startDate: DateTime.now(),
          userId: userId,
        );
        await budgetProvider.addBudget(newBudget);
        if (mounted) {
          GlassSnackBar.showSuccess(
            context,
            message: 'Budget created successfully',
          );
        }
      } else {
        final updatedBudget = Budget(
          id: widget.budget!.id,
          category: _selectedCategory,
          amount: amount,
          period: _selectedPeriod,
          startDate: widget.budget!.startDate,
          userId: userId,
        );
        await budgetProvider.updateBudget(updatedBudget);
        if (mounted) {
          GlassSnackBar.showSuccess(
            context,
            message: 'Budget updated successfully',
          );
        }
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        GlassSnackBar.showError(context, message: 'Failed to save budget: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.budget == null ? 'New Budget' : 'Edit Budget',
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
                            'Budget Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),

                          // Category Selection
                          Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 6),
                          ..._categories.map((cat) {
                            final isSelected = _selectedCategory == cat['name'];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: GestureDetector(
                                onTap: () => setState(
                                  () => _selectedCategory = cat['name'],
                                ),
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
                                          cat['icon'],
                                          color: AppColors.primary,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        cat['name'],
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

                          // Budget Amount
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Budget Limit',
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
                                    hintText: '0.00',
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
                                      return 'Please enter an amount';
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

                          // Period Selection
                          GlassContainer(
                            padding: EdgeInsets.all(3),
                            borderRadius: BorderRadius.circular(12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => _selectedPeriod = 'monthly',
                                    ),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _selectedPeriod == 'monthly'
                                            ? AppColors.primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Monthly',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                              _selectedPeriod == 'monthly'
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(
                                      () => _selectedPeriod = 'yearly',
                                    ),
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 200),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _selectedPeriod == 'yearly'
                                            ? AppColors.primary
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Yearly',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                              _selectedPeriod == 'yearly'
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
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
                            'Cancel',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveBudget,
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
                                  'Save Budget',
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
