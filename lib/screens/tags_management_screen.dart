import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/tag_provider.dart';
import '../models/tag.dart';
import '../utils/app_colors.dart';
import '../widgets/glass_container.dart';
import 'add_edit_tag_screen.dart';

class TagsManagementScreen extends StatefulWidget {
  const TagsManagementScreen({super.key});

  @override
  State<TagsManagementScreen> createState() => _TagsManagementScreenState();
}

class _TagsManagementScreenState extends State<TagsManagementScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<TagProvider>(context, listen: false).fetchTags();
      }
    });
  }

  void _navigateToAddEditTag([Tag? tag]) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditTagScreen(tag: tag)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Manage Tags',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
          // Blobs
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    blurRadius: 80,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Consumer<TagProvider>(
              builder: (context, provider, child) {
                final tags = provider.tags;

                if (tags.isEmpty) {
                  return Center(
                    child: Text(
                      'No tags created yet.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    final tag = tags[index];
                    return Dismissible(
                      key: Key(tag.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        color: AppColors.error,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Delete Tag?'),
                            content: Text(
                              'Are you sure you want to delete this tag? It will be removed from all transactions.',
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () => Navigator.pop(ctx, false),
                              ),
                              TextButton(
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: AppColors.error),
                                ),
                                onPressed: () => Navigator.pop(ctx, true),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (direction) {
                        provider.deleteTag(tag.id);
                      },
                      child: InkWell(
                        onLongPress: () {
                          HapticFeedback.mediumImpact();
                          _navigateToAddEditTag(tag);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: GlassContainer(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Color(tag.color),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  tag.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => _navigateToAddEditTag(),
      ),
    );
  }
}
