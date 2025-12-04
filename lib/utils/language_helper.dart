class Language {
  final String name;
  final String code;
  final String nativeName;

  const Language({
    required this.name,
    required this.code,
    required this.nativeName,
  });
}

class LanguageHelper {
  // A comprehensive list of world languages
  static const List<Language> languages = [
    Language(name: 'English', code: 'en', nativeName: 'English'),
    Language(name: 'Hindi', code: 'hi', nativeName: 'हिन्दी'),
    Language(name: 'Spanish', code: 'es', nativeName: 'Español'),
    Language(name: 'French', code: 'fr', nativeName: 'Français'),
    Language(name: 'Arabic', code: 'ar', nativeName: 'العربية'),
    Language(name: 'Bengali', code: 'bn', nativeName: 'বাংলা'),
    Language(name: 'Portuguese', code: 'pt', nativeName: 'Português'),
    Language(name: 'Russian', code: 'ru', nativeName: 'Русский'),
    Language(name: 'Urdu', code: 'ur', nativeName: 'اردو'),
    Language(name: 'Indonesian', code: 'id', nativeName: 'Bahasa Indonesia'),
    Language(name: 'German', code: 'de', nativeName: 'Deutsch'),
    Language(name: 'Japanese', code: 'ja', nativeName: '日本語'),
    Language(name: 'Marathi', code: 'mr', nativeName: 'मराठी'),
    Language(name: 'Telugu', code: 'te', nativeName: 'తెలుగు'),
    Language(name: 'Turkish', code: 'tr', nativeName: 'Türkçe'),
    Language(name: 'Tamil', code: 'ta', nativeName: 'தமிழ்'),
    Language(name: 'Korean', code: 'ko', nativeName: '한국어'),
    Language(name: 'Vietnamese', code: 'vi', nativeName: 'Tiếng Việt'),
    Language(name: 'Italian', code: 'it', nativeName: 'Italiano'),
    Language(name: 'Thai', code: 'th', nativeName: 'ไทย'),
    Language(name: 'Gujarati', code: 'gu', nativeName: 'ગુજરાતી'),
    Language(name: 'Kannada', code: 'kn', nativeName: 'ಕನ್ನಡ'),
    Language(name: 'Persian', code: 'fa', nativeName: 'فارسی'),
    Language(name: 'Polish', code: 'pl', nativeName: 'Polski'),
    Language(name: 'Malayalam', code: 'ml', nativeName: 'മലയാളം'),
    Language(name: 'Chinese (Simplified)', code: 'zh', nativeName: '简体中文'),
    Language(
      name: 'Chinese (Traditional)',
      code: 'zh_Hant',
      nativeName: '繁體中文',
    ),
    // Add more as needed, this is a good starting list covering major world and Indian languages
  ];

  static String getName(String code) {
    try {
      return languages.firstWhere((l) => l.code == code).name;
    } catch (e) {
      return code;
    }
  }

  static String getNativeName(String code) {
    try {
      return languages.firstWhere((l) => l.code == code).nativeName;
    } catch (e) {
      return code;
    }
  }
}
