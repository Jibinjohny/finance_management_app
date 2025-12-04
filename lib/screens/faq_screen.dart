import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/glass_container.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int? _expandedIndex;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FAQItem> get _filteredFaqs {
    if (_searchQuery.isEmpty) {
      return _faqs;
    }
    return _faqs.where((faq) {
      return faq.question.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq.answer.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  List<FAQItem> get _faqs {
    final l10n = AppLocalizations.of(context)!;
    return [
      FAQItem(question: l10n.faqQ1, answer: l10n.faqA1),
      FAQItem(question: l10n.faqQ2, answer: l10n.faqA2),
      FAQItem(question: l10n.faqQ3, answer: l10n.faqA3),
      FAQItem(question: l10n.faqQ4, answer: l10n.faqA4),
      FAQItem(question: l10n.faqQ5, answer: l10n.faqA5),
      FAQItem(question: l10n.faqQ6, answer: l10n.faqA6),
      FAQItem(question: l10n.faqQ7, answer: l10n.faqA7),
      FAQItem(question: l10n.faqQ8, answer: l10n.faqA8),
      FAQItem(question: l10n.faqQ9, answer: l10n.faqA9),
      FAQItem(question: l10n.faqQ10, answer: l10n.faqA10),
      FAQItem(question: l10n.faqQ11, answer: l10n.faqA11),
      FAQItem(question: l10n.faqQ12, answer: l10n.faqA12),
      FAQItem(question: l10n.faqQ13, answer: l10n.faqA13),
      FAQItem(question: l10n.faqQ14, answer: l10n.faqA14),
      FAQItem(question: l10n.faqQ15, answer: l10n.faqA15),
      FAQItem(question: l10n.faqQ16, answer: l10n.faqA16),
      FAQItem(question: l10n.faqQ17, answer: l10n.faqA17),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.faqTitle,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassContainer(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                borderRadius: BorderRadius.circular(16),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.faqSearchHint,
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.white54),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.white54),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: _filteredFaqs.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.faqNoResults,
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: _filteredFaqs.length,
                      itemBuilder: (context, index) {
                        final faq = _filteredFaqs[index];
                        final isExpanded = _expandedIndex == index;

                        return Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: GlassContainer(
                            padding: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(16),
                            child: Theme(
                              data: Theme.of(
                                context,
                              ).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                onExpansionChanged: (expanded) {
                                  setState(() {
                                    _expandedIndex = expanded ? index : null;
                                  });
                                },
                                leading: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.help_outline,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                                title: Text(
                                  faq.question,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Colors.white70,
                                ),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                    child: Text(
                                      faq.answer,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
