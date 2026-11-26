import '../constants/app_texts.dart';

extension NumExtensions on num {
  /// Rupiah: 25475500 → "Rp 25.475.500" (dot thousands, no decimals).
  String toCurrency({String symbol = AppTexts.currencySymbol}) {
    final isNegative = this < 0;
    final whole = abs().round().toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => '.',
    );
    return '${isNegative ? '-' : ''}$symbol $whole';
  }

  /// Signed currency for transaction lists: "+Rp 250.000" / "-Rp 75.000".
  String toSignedCurrency({String symbol = AppTexts.currencySymbol}) =>
      '${this >= 0 ? '+' : '-'}${abs().toCurrency(symbol: symbol)}';
}
