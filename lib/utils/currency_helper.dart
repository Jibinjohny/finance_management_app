import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class Currency {
  final String symbol;
  final String name;
  final String code;

  const Currency({
    required this.symbol,
    required this.name,
    required this.code,
  });
}

class CurrencyHelper {
  static const List<Currency> currencies = [
    Currency(symbol: '₹', name: 'Indian Rupee', code: 'INR'),
    Currency(symbol: '\$', name: 'US Dollar', code: 'USD'),
    Currency(symbol: '€', name: 'Euro', code: 'EUR'),
    Currency(symbol: '£', name: 'British Pound', code: 'GBP'),
    Currency(symbol: '¥', name: 'Japanese Yen', code: 'JPY'),
    Currency(symbol: 'A\$', name: 'Australian Dollar', code: 'AUD'),
    Currency(symbol: 'C\$', name: 'Canadian Dollar', code: 'CAD'),
    Currency(symbol: 'Fr', name: 'Swiss Franc', code: 'CHF'),
    Currency(symbol: '¥', name: 'Chinese Yuan', code: 'CNY'),
    Currency(symbol: 'kr', name: 'Swedish Krona', code: 'SEK'),
    Currency(symbol: 'NZ\$', name: 'New Zealand Dollar', code: 'NZD'),
    Currency(symbol: '\$', name: 'Mexican Peso', code: 'MXN'),
    Currency(symbol: 'S\$', name: 'Singapore Dollar', code: 'SGD'),
    Currency(symbol: 'HK\$', name: 'Hong Kong Dollar', code: 'HKD'),
    Currency(symbol: 'kr', name: 'Norwegian Krone', code: 'NOK'),
    Currency(symbol: '₩', name: 'South Korean Won', code: 'KRW'),
    Currency(symbol: '₺', name: 'Turkish Lira', code: 'TRY'),
    Currency(symbol: '₽', name: 'Russian Ruble', code: 'RUB'),
    Currency(symbol: 'R\$', name: 'Brazilian Real', code: 'BRL'),
    Currency(symbol: 'R', name: 'South African Rand', code: 'ZAR'),
    Currency(symbol: '₱', name: 'Philippine Peso', code: 'PHP'),
    Currency(symbol: 'Rp', name: 'Indonesian Rupiah', code: 'IDR'),
    Currency(symbol: '฿', name: 'Thai Baht', code: 'THB'),
    Currency(symbol: '₫', name: 'Vietnamese Dong', code: 'VND'),
    Currency(symbol: 'RM', name: 'Malaysian Ringgit', code: 'MYR'),
    Currency(symbol: 'Ft', name: 'Hungarian Forint', code: 'HUF'),
    Currency(symbol: 'Kč', name: 'Czech Koruna', code: 'CZK'),
    Currency(symbol: 'zł', name: 'Polish Zloty', code: 'PLN'),
    Currency(symbol: '₪', name: 'Israeli New Shekel', code: 'ILS'),
    Currency(symbol: 'CLP\$', name: 'Chilean Peso', code: 'CLP'),
    Currency(symbol: 'د.إ', name: 'UAE Dirham', code: 'AED'),
    Currency(symbol: 'SAR', name: 'Saudi Riyal', code: 'SAR'),
    Currency(symbol: 'E£', name: 'Egyptian Pound', code: 'EGP'),
    Currency(symbol: 'Tk', name: 'Bangladeshi Taka', code: 'BDT'),
    Currency(symbol: 'Rs', name: 'Pakistani Rupee', code: 'PKR'),
    Currency(symbol: '₦', name: 'Nigerian Naira', code: 'NGN'),
    Currency(symbol: 'KSh', name: 'Kenyan Shilling', code: 'KES'),
    Currency(symbol: '₵', name: 'Ghanaian Cedi', code: 'GHS'),
    Currency(symbol: 'лв', name: 'Bulgarian Lev', code: 'BGN'),
    Currency(symbol: 'lei', name: 'Romanian Leu', code: 'RON'),
    Currency(symbol: 'kn', name: 'Croatian Kuna', code: 'HRK'),
    Currency(symbol: 'kr', name: 'Danish Krone', code: 'DKK'),
    Currency(symbol: 'kr', name: 'Icelandic Króna', code: 'ISK'),
    Currency(symbol: 'L', name: 'Albanian Lek', code: 'ALL'),
    Currency(symbol: 'KM', name: 'Bosnia-Herzegovina Mark', code: 'BAM'),
    Currency(symbol: 'ден', name: 'Macedonian Denar', code: 'MKD'),
    Currency(symbol: 'din', name: 'Serbian Dinar', code: 'RSD'),
    Currency(symbol: '₴', name: 'Ukrainian Hryvnia', code: 'UAH'),
    Currency(symbol: '₾', name: 'Georgian Lari', code: 'GEL'),
    Currency(symbol: '֏', name: 'Armenian Dram', code: 'AMD'),
    Currency(symbol: '₼', name: 'Azerbaijani Manat', code: 'AZN'),
    Currency(symbol: '₸', name: 'Kazakhstani Tenge', code: 'KZT'),
    Currency(symbol: 'so\'m', name: 'Uzbekistani Som', code: 'UZS'),
    Currency(symbol: 'Q', name: 'Guatemalan Quetzal', code: 'GTQ'),
    Currency(symbol: 'L', name: 'Honduran Lempira', code: 'HNL'),
    Currency(symbol: 'C\$', name: 'Nicaraguan Córdoba', code: 'NIO'),
    Currency(symbol: '₡', name: 'Costa Rican Colón', code: 'CRC'),
    Currency(symbol: 'B/.', name: 'Panamanian Balboa', code: 'PAB'),
    Currency(symbol: 'RD\$', name: 'Dominican Peso', code: 'DOP'),
    Currency(symbol: 'J\$', name: 'Jamaican Dollar', code: 'JMD'),
    Currency(symbol: 'TT\$', name: 'Trinidad/Tobago Dollar', code: 'TTD'),
    Currency(symbol: 'Bs.', name: 'Venezuelan Bolívar', code: 'VES'),
    Currency(symbol: 'S/', name: 'Peruvian Sol', code: 'PEN'),
    Currency(symbol: 'Gs', name: 'Paraguayan Guaraní', code: 'PYG'),
    Currency(symbol: '\$U', name: 'Uruguayan Peso', code: 'UYU'),
    Currency(symbol: 'Bs', name: 'Bolivian Boliviano', code: 'BOB'),
  ];

  static String getSymbol(BuildContext context, {bool listen = true}) {
    final user = Provider.of<AuthProvider>(context, listen: listen).currentUser;
    return user?.currency ?? '₹';
  }

  static String getName(String symbol) {
    try {
      return currencies.firstWhere((c) => c.symbol == symbol).name;
    } catch (e) {
      return 'Currency';
    }
  }

  static Currency getCurrencyBySymbol(String symbol) {
    try {
      return currencies.firstWhere((c) => c.symbol == symbol);
    } catch (e) {
      return currencies.first;
    }
  }
}
