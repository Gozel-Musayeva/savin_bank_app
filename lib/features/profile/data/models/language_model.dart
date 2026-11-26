/// App language option (Account → Language). UI-only: the app copy stays
/// English until localisation is added.
class LanguageModel {
  const LanguageModel({
    required this.code,
    required this.name,
    required this.flag,
  });

  /// ISO 639-1 code, e.g. "en".
  final String code;
  final String name;

  /// Flag emoji drawn in a circle.
  final String flag;

  static const english = LanguageModel(
    code: 'en',
    name: 'English',
    flag: '🇺🇸',
  );

  static const languages = [
    english,
    LanguageModel(code: 'id', name: 'Indonesia', flag: '🇮🇩'),
    LanguageModel(code: 'zh', name: 'Chinese', flag: '🇨🇳'),
    LanguageModel(code: 'ja', name: 'Japanese', flag: '🇯🇵'),
  ];
}
