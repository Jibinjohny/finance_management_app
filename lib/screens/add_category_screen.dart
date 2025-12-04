import 'package:flutter/material.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';
import '../providers/category_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/glass_container.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/income_expense_switch.dart';

class AddCategoryScreen extends StatefulWidget {
  final Category? category;

  const AddCategoryScreen({super.key, this.category});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _nameController = TextEditingController();
  CategoryType _selectedType = CategoryType.expense;
  int _selectedIcon = Icons.category.codePoint;
  int _selectedColor = Colors.blue.value;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {});
    });
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _selectedType = widget.category!.type;
      _selectedIcon = widget.category!.iconCodePoint;
      _selectedColor = widget.category!.colorValue;
    }
  }

  final List<int> _icons = [
    Icons.restaurant.codePoint,
    Icons.directions_bus.codePoint,
    Icons.shopping_bag.codePoint,
    Icons.receipt_long.codePoint,
    Icons.movie.codePoint,
    Icons.medical_services.codePoint,
    Icons.school.codePoint,
    Icons.fitness_center.codePoint,
    Icons.pets.codePoint,
    Icons.flight.codePoint,
    Icons.home.codePoint,
    Icons.work.codePoint,
    Icons.computer.codePoint,
    Icons.build.codePoint,
    Icons.local_grocery_store.codePoint,
    Icons.sports_esports.codePoint,
    Icons.music_note.codePoint,
    Icons.local_cafe.codePoint,
    Icons.local_bar.codePoint,
    Icons.child_care.codePoint,
  ];

  final List<int> _colors = [
    Colors.red.toARGB32(),
    Colors.pink.toARGB32(),
    Colors.purple.toARGB32(),
    Colors.deepPurple.toARGB32(),
    Colors.indigo.toARGB32(),
    Colors.blue.toARGB32(),
    Colors.lightBlue.toARGB32(),
    Colors.cyan.toARGB32(),
    Colors.teal.toARGB32(),
    Colors.green.toARGB32(),
    Colors.lightGreen.toARGB32(),
    Colors.lime.toARGB32(),
    Colors.yellow.toARGB32(),
    Colors.amber.toARGB32(),
    Colors.orange.toARGB32(),
    Colors.deepOrange.toARGB32(),
    Colors.brown.toARGB32(),
    Colors.grey.toARGB32(),
    Colors.blueGrey.toARGB32(),
  ];

  void _saveCategory() {
    if (_nameController.text.isEmpty) {
      GlassSnackBar.show(
        context,
        message: AppLocalizations.of(context)!.categoryNameError,
      );
      return;
    }

    final category = Category(
      id: widget.category?.id ?? const Uuid().v4(),
      name: _nameController.text,
      iconCodePoint: _selectedIcon,
      colorValue: _selectedColor,
      type: _selectedType,
      isDefault: widget.category?.isDefault ?? false,
    );

    final provider = Provider.of<CategoryProvider>(context, listen: false);

    if (widget.category != null) {
      provider.updateCategory(category);
    } else {
      provider.addCategory(category);
    }
    Navigator.pop(context);
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
          widget.category != null
              ? AppLocalizations.of(context)!.editCategoryTitle
              : AppLocalizations.of(context)!.addCategoryTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Input
                GlassContainer(
                  padding: EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(16),
                  child: TextField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        context,
                      )!.categoryNameLabel,
                      labelStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.edit, color: Colors.white70),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Type Selector
                IncomeExpenseSwitch(
                  isExpense: _selectedType == CategoryType.expense,
                  onIsExpenseChanged: (isExpense) {
                    setState(() {
                      _selectedType = isExpense
                          ? CategoryType.expense
                          : CategoryType.income;
                    });
                  },
                ),
                SizedBox(height: 20),

                // Icon Selector
                Text(
                  AppLocalizations.of(context)!.selectIconLabel,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                GlassContainer(
                  padding: EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _icons.length,
                    itemBuilder: (context, index) {
                      final icon = _icons[index];
                      final isSelected = _selectedIcon == icon;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedIcon = icon),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                          ),
                          child: Icon(
                            IconData(icon, fontFamily: 'MaterialIcons'),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Color Selector
                Text(
                  AppLocalizations.of(context)!.selectColorLabel,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                GlassContainer(
                  padding: EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _colors.length,
                    itemBuilder: (context, index) {
                      final color = _colors[index];
                      final isSelected = _selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = color),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(color),
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                          ),
                          child: isSelected
                              ? Icon(Icons.check, color: Colors.white, size: 20)
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),

                // Preview Section
                Text(
                  AppLocalizations.of(context)!.previewLabel,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconData(_selectedIcon, fontFamily: 'MaterialIcons'),
                          color: Color(_selectedColor),
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          _nameController.text.isEmpty
                              ? AppLocalizations.of(context)!.categoryNameLabel
                              : _nameController.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _saveCategory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.saveCategoryButton,
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
          ),
        ),
      ),
    );
  }
}
