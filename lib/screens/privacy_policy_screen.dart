import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          AppLocalizations.of(context)!.privacyPolicyTitle,
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                AppLocalizations.of(context)!.lastUpdated,
                'November 20, 2025',
              ),
              SizedBox(height: 20),
              _buildSection(
                AppLocalizations.of(context)!.privacyIntroTitle,
                AppLocalizations.of(context)!.privacyIntroContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyDataCollectionTitle,
                AppLocalizations.of(context)!.privacyDataCollectionContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyDataStorageTitle,
                AppLocalizations.of(context)!.privacyDataStorageContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyDataSharingTitle,
                AppLocalizations.of(context)!.privacyDataSharingContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyPermissionsTitle,
                AppLocalizations.of(context)!.privacyPermissionsContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyDataSecurityTitle,
                AppLocalizations.of(context)!.privacyDataSecurityContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyYourRightsTitle,
                AppLocalizations.of(context)!.privacyYourRightsContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyChildrenTitle,
                AppLocalizations.of(context)!.privacyChildrenContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyChangesTitle,
                AppLocalizations.of(context)!.privacyChangesContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.privacyContactTitle,
                AppLocalizations.of(context)!.privacyContactContent,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.6),
          ),
        ],
      ),
    );
  }
}
