import 'package:flutter/material.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class LocalizationHelper {
  static String getLocalizedCategoryName(
    BuildContext context,
    String category,
  ) {
    switch (category) {
      case 'Food':
        return AppLocalizations.of(context)!.categoryFood;
      case 'Transport':
        return AppLocalizations.of(context)!.categoryTransport;
      case 'Shopping':
        return AppLocalizations.of(context)!.categoryShopping;
      case 'Bills':
        return AppLocalizations.of(context)!.categoryBills;
      case 'Entertainment':
        return AppLocalizations.of(context)!.categoryEntertainment;
      case 'Health':
        return AppLocalizations.of(context)!.categoryHealth;
      case 'Other':
        return AppLocalizations.of(context)!.categoryOther;
      case 'Salary':
        return AppLocalizations.of(context)!.categorySalary;
      case 'Freelance':
        return AppLocalizations.of(context)!.categoryFreelance;
      case 'Business':
        return AppLocalizations.of(context)!.categoryBusiness;
      case 'Investment':
        return AppLocalizations.of(context)!.categoryInvestment;
      case 'Gift':
        return AppLocalizations.of(context)!.categoryGift;
      default:
        return category;
    }
  }

  static String getLocalizedPaymentMode(BuildContext context, String mode) {
    switch (mode) {
      case 'Cash':
        return AppLocalizations.of(context)!.paymentModeCash;
      case 'Credit Card':
        return AppLocalizations.of(context)!.paymentModeCreditCard;
      case 'Debit Card':
        return AppLocalizations.of(context)!.paymentModeDebitCard;
      case 'UPI':
        return AppLocalizations.of(context)!.paymentModeUPI;
      case 'Net Banking':
        return AppLocalizations.of(context)!.paymentModeNetBanking;
      case 'Other':
        return AppLocalizations.of(context)!.paymentModeOther;
      default:
        return mode;
    }
  }
}
