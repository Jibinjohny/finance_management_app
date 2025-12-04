import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/tag.dart';
import '../providers/tag_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';

class AddEditTagScreen extends StatefulWidget {
  final Tag? tag;

  const AddEditTagScreen({super.key, this.tag});

  @override
  State<AddEditTagScreen> createState() => _AddEditTagScreenState();
}

class _AddEditTagScreenState extends State<AddEditTagScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  Color _selectedColor = AppColors.primary;
  bool _isLoading = false;

  final List<Color> _colorOptions = [
    Color(0xFF2196F3), // Blue
    Color(0xFF4CAF50), // Green
    Color(0xFFFFC107), // Amber
    Color(0xFFE91E63), // Pink
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFF5722), // Deep Orange
    Color(0xFF795548), // Brown
    Color(0xFF607D8B), // Blue Grey
    Color(0xFFFF9800), // Orange
    Color(0xFF8BC34A), // Light Green
    Color(0xFF3F51B5), // Indigo
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tag?.name ?? '');
    if (widget.tag != null) {
      _selectedColor = Color(widget.tag!.color);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveTag() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final tagProvider = Provider.of<TagProvider>(context, listen: false);
      final userId = authProvider.currentUser!.id;

      if (widget.tag != null) {
        final updatedTag = Tag(
          id: widget.tag!.id,
          name: _nameController.text,
          color: _selectedColor.value,
          userId: userId,
        );
        await tagProvider.updateTag(updatedTag);
        if (mounted) {
          GlassSnackBar.showSuccess(
            context,
            message: 'Tag updated successfully',
          );
        }
      } else {
        final newTag = Tag(
          id: const Uuid().v4(),
          name: _nameController.text,
          color: _selectedColor.value,
          userId: userId,
        );
        await tagProvider.addTag(newTag);
        if (mounted) {
          GlassSnackBar.showSuccess(
            context,
            message: 'Tag created successfully',
          );
        }
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        GlassSnackBar.showError(context, message: 'Failed to save tag: $e');
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
          widget.tag != null ? 'Edit Tag' : 'New Tag',
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
                            'Tag Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),

                          // Tag Name
                          GlassContainer(
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tag Name',
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
                                    hintText: 'e.g., Personal, Work, Urgent',
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) => value!.isEmpty
                                      ? 'Please enter a tag name'
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),

                          // Color Selection
                          Text(
                            'Color',
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
                                  'Choose a color for your tag',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: _colorOptions.map((color) {
                                    final isSelected = _selectedColor == color;
                                    return GestureDetector(
                                      onTap: () => setState(
                                        () => _selectedColor = color,
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 200),
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: color,
                                          shape: BoxShape.circle,
                                          border: isSelected
                                              ? Border.all(
                                                  color: Colors.white,
                                                  width: 3,
                                                )
                                              : null,
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color: color.withValues(
                                                      alpha: 0.5,
                                                    ),
                                                    blurRadius: 8,
                                                    spreadRadius: 2,
                                                  ),
                                                ]
                                              : null,
                                        ),
                                        child: isSelected
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 24,
                                              )
                                            : null,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),

                          // Preview
                          Text(
                            'Preview',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),

                          GlassContainer(
                            padding: EdgeInsets.all(16),
                            borderRadius: BorderRadius.circular(14),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _selectedColor.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _selectedColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: _selectedColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        _nameController.text.isEmpty
                                            ? 'Tag Name'
                                            : _nameController.text,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
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
                          onPressed: _isLoading ? null : _saveTag,
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
                                  'Save Tag',
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
