import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/language_helper.dart';
import 'glass_container.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class LanguageSelectionSheet extends StatefulWidget {
  final String selectedLanguageCode;

  const LanguageSelectionSheet({super.key, required this.selectedLanguageCode});

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  late TextEditingController _searchController;
  List<Language> _filteredLanguages = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredLanguages = LanguageHelper.languages;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterLanguages(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLanguages = LanguageHelper.languages;
      } else {
        _filteredLanguages = LanguageHelper.languages.where((language) {
          final nameLower = language.name.toLowerCase();
          final codeLower = language.code.toLowerCase();
          final nativeNameLower = language.nativeName.toLowerCase();
          final searchLower = query.toLowerCase();

          return nameLower.contains(searchLower) ||
              codeLower.contains(searchLower) ||
              nativeNameLower.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: GlassContainer(
              padding: EdgeInsets.symmetric(horizontal: 16),
              borderRadius: BorderRadius.circular(15),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchLanguage,
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.white54),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.white54),
                          onPressed: () {
                            _searchController.clear();
                            _filterLanguages('');
                          },
                        )
                      : null,
                ),
                onChanged: _filterLanguages,
              ),
            ),
          ),

          // List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _filteredLanguages.length,
              itemBuilder: (context, index) {
                final language = _filteredLanguages[index];
                final isSelected = language.code == widget.selectedLanguageCode;

                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, language.code);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isSelected
                            ? [
                                AppColors.primary.withValues(alpha: 0.3),
                                AppColors.primary.withValues(alpha: 0.1),
                              ]
                            : [
                                Colors.white.withValues(alpha: 0.1),
                                Colors.white.withValues(alpha: 0.05),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.5)
                            : Colors.white.withValues(alpha: 0.1),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                blurRadius: 12,
                                spreadRadius: 0,
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              language.code.toUpperCase().substring(0, 2),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                language.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                language.nativeName,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check_circle, color: AppColors.primary),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
