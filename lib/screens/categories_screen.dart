import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../models/category.dart';
import '../utils/app_colors.dart';
import '../widgets/glass_container.dart';
import 'add_category_screen.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/income_expense_switch.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoryType _selectedType = CategoryType.expense;

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
          'Categories',
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
                ],
              ),
            ),
          ),

          // Blob 1: Top Left
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 150,
                    spreadRadius: 80,
                  ),
                ],
              ),
            ),
          ),

          // Blob 2: Middle Right
          Positioned(
            top: 300,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),

          // Blob 3: Bottom Left
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 90,
                    spreadRadius: 45,
                  ),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Filter Chips
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: IncomeExpenseSwitch(
                    isExpense: _selectedType == CategoryType.expense,
                    onIsExpenseChanged: (isExpense) {
                      setState(() {
                        _selectedType = isExpense
                            ? CategoryType.expense
                            : CategoryType.income;
                      });
                    },
                  ),
                ),

                // Category List
                Expanded(child: _CategoryList(type: _selectedType)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddCategoryScreen(
                category: Category(
                  id: '',
                  name: '',
                  iconCodePoint: Icons.category.codePoint,
                  colorValue: Colors.blue.value,
                  type: _selectedType, // Pass selected type
                  isDefault: false,
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  final CategoryType type;

  const _CategoryList({required this.type});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, child) {
        final categories = type == CategoryType.expense
            ? provider.expenseCategories
            : provider.incomeCategories;

        if (categories.isEmpty) {
          return Center(
            child: Text(
              'No categories found',
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16),
          itemCount: categories.length,
          separatorBuilder: (context, index) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final category = categories[index];
            return Dismissible(
              key: Key(category.id),
              direction: category.isDefault
                  ? DismissDirection.none
                  : DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: AppColors.surface,
                    title: Text(
                      'Delete Category?',
                      style: TextStyle(color: Colors.white),
                    ),
                    content: Text(
                      'Are you sure you want to delete "${category.name}"?',
                      style: TextStyle(color: Colors.white70),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onDismissed: (direction) {
                provider.deleteCategory(category.id);
              },
              child: GestureDetector(
                onTap: () {
                  if (!category.isDefault) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddCategoryScreen(category: category),
                      ),
                    );
                  } else {
                    GlassSnackBar.show(
                      context,
                      message: 'Default categories cannot be edited',
                    );
                  }
                },
                child: GlassContainer(
                  padding: EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(16),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(
                            category.colorValue,
                          ).withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          IconData(
                            category.iconCodePoint,
                            fontFamily: 'MaterialIcons',
                          ),
                          color: Color(category.colorValue),
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          category.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (category.isDefault)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Default',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
