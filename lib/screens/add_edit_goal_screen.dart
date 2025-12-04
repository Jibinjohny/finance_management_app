import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/goal.dart';
import '../providers/goal_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import '../utils/currency_helper.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';

class AddEditGoalScreen extends StatefulWidget {
  final Goal? goal;

  const AddEditGoalScreen({super.key, this.goal});

  @override
  State<AddEditGoalScreen> createState() => _AddEditGoalScreenState();
}

class _AddEditGoalScreenState extends State<AddEditGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _targetAmountController;
  late TextEditingController _currentAmountController;
  DateTime? _deadline;
  Color _selectedColor = AppColors.primary;
  int _selectedIcon = Icons.flag.codePoint;

  bool _isLoading = false;

  final List<Map<String, dynamic>> _iconOptions = [
    {'icon': Icons.flag, 'label': 'Flag'},
    {'icon': Icons.directions_car, 'label': 'Car'},
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.flight, 'label': 'Travel'},
    {'icon': Icons.school, 'label': 'Education'},
    {'icon': Icons.laptop, 'label': 'Laptop'},
    {'icon': Icons.phone_iphone, 'label': 'Phone'},
    {'icon': Icons.shopping_bag, 'label': 'Shopping'},
    {'icon': Icons.savings, 'label': 'Savings'},
    {'icon': Icons.favorite, 'label': 'Other'},
  ];

  final List<Color> _colorOptions = [
    Color(0xFF2196F3), // Blue
    Color(0xFF4CAF50), // Green
    Color(0xFFFFC107), // Amber
    Color(0xFFE91E63), // Pink
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFF5722), // Deep Orange
    Color(0xFF795548), // Brown
  ];

  @override
  void initState() {
    super.initState();
    final item = widget.goal;
    _nameController = TextEditingController(text: item?.name ?? '');
    _targetAmountController = TextEditingController(
      text: item?.targetAmount.toString() ?? '',
    );
    _currentAmountController = TextEditingController(
      text: item?.currentAmount.toString() ?? '0.0',
    );
    _deadline = item?.deadline;
    if (item != null) {
      _selectedColor = Color(item.color);
      _selectedIcon = item.icon;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetAmountController.dispose();
    _currentAmountController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final provider = Provider.of<GoalProvider>(context, listen: false);
      final userId = authProvider.currentUser!.id;

      final targetAmount = double.parse(_targetAmountController.text);
      final currentAmount = double.parse(_currentAmountController.text);

      final newGoal = Goal(
        id: widget.goal?.id ?? const Uuid().v4(),
        name: _nameController.text,
        targetAmount: targetAmount,
        currentAmount: currentAmount,
        deadline: _deadline,
        icon: _selectedIcon,
        color: _selectedColor.toARGB32(),
        userId: userId,
      );

      if (widget.goal != null) {
        await provider.updateGoal(newGoal);
      } else {
        await provider.addGoal(newGoal);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        GlassSnackBar.showError(context, message: 'Error saving goal: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteGoal() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('Delete Goal?', style: TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to delete this goal?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Colors.white70)),
            onPressed: () => Navigator.pop(ctx, false),
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(color: AppColors.error)),
            onPressed: () => Navigator.pop(ctx, true),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await Provider.of<GoalProvider>(
        context,
        listen: false,
      ).deleteGoal(widget.goal!.id);
      if (mounted) Navigator.pop(context);
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
          widget.goal != null ? 'Edit Goal' : 'New Goal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (widget.goal != null)
            IconButton(
              icon: Icon(Icons.delete, color: AppColors.error),
              onPressed: _deleteGoal,
            ),
        ],
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
                            'Goal Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),

                          // Goal Name
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Goal Name',
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
                                    hintText: 'e.g., Dream Vacation',
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter a name'
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          // Target Amount
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Target Amount',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextFormField(
                                  controller: _targetAmountController,
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
                                    if (value == null || value.isEmpty)
                                      return 'Please enter amount';
                                    if (double.tryParse(value) == null)
                                      return 'Invalid amount';
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          // Current Saved Amount
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Saved Amount',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                TextFormField(
                                  controller: _currentAmountController,
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '0.00',
                                    hintStyle: TextStyle(color: Colors.white38),
                                    prefixText:
                                        '${CurrencyHelper.getSymbol(context)} ',
                                    prefixStyle: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty)
                                      return 'Please enter amount';
                                    if (double.tryParse(value) == null)
                                      return 'Invalid amount';
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          // Deadline
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
                                      'Deadline (Optional)',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      _deadline != null
                                          ? DateFormat(
                                              'MMM d, y',
                                            ).format(_deadline!)
                                          : 'No deadline set',
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
                                      initialDate:
                                          _deadline ??
                                          DateTime.now().add(
                                            Duration(days: 30),
                                          ),
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
                                      setState(() => _deadline = picked);
                                    }
                                  },
                                  child: Text(
                                    _deadline != null ? 'Change' : 'Select',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),

                          // Appearance
                          Text(
                            'Appearance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),

                          // Color Selection
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Color',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _colorOptions.map((color) {
                                    final isSelected = _selectedColor == color;
                                    return GestureDetector(
                                      onTap: () => setState(
                                        () => _selectedColor = color,
                                      ),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: color,
                                          shape: BoxShape.circle,
                                          border: isSelected
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
                              ],
                            ),
                          ),
                          SizedBox(height: 8),

                          // Icon Selection
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Icon',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: _iconOptions.map((iconData) {
                                    final icon = iconData['icon'] as IconData;
                                    final isSelected =
                                        _selectedIcon == icon.codePoint;
                                    return GestureDetector(
                                      onTap: () => setState(
                                        () => _selectedIcon = icon.codePoint,
                                      ),
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.1,
                                          ),
                                          shape: BoxShape.circle,
                                          border: isSelected
                                              ? Border.all(
                                                  color: AppColors.primary,
                                                  width: 2,
                                                )
                                              : null,
                                        ),
                                        child: Icon(
                                          icon,
                                          color: isSelected
                                              ? AppColors.primary
                                              : Colors.white54,
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
                            'Cancel',
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
                                  'Save Goal',
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
