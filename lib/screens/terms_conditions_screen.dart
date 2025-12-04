import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
          AppLocalizations.of(context)!.termsTitle,
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
                AppLocalizations.of(context)!.termsAcceptanceTitle,
                AppLocalizations.of(context)!.termsAcceptanceContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsLicenseTitle,
                AppLocalizations.of(context)!.termsLicenseContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsUserRespTitle,
                AppLocalizations.of(context)!.termsUserRespContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsDisclaimerTitle,
                AppLocalizations.of(context)!.termsDisclaimerContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsLiabilityTitle,
                AppLocalizations.of(context)!.termsLiabilityContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsAdviceTitle,
                AppLocalizations.of(context)!.termsAdviceContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsAccuracyTitle,
                AppLocalizations.of(context)!.termsAccuracyContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsUpdatesTitle,
                AppLocalizations.of(context)!.termsUpdatesContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsIPTitle,
                AppLocalizations.of(context)!.termsIPContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsTerminationTitle,
                AppLocalizations.of(context)!.termsTerminationContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsGoverningTitle,
                AppLocalizations.of(context)!.termsGoverningContent,
              ),
              _buildSection(
                AppLocalizations.of(context)!.termsContactTitle,
                AppLocalizations.of(context)!.termsContactContent,
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.termsFooter,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
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
