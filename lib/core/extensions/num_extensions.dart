import '../constants/app_texts.dart';

extension NumExtensions on num {
  /// 12500.5 → "$12,500.50"
  String toCurrency({String symbol = AppTexts.currencySymbol}) {
    final isNegative = this < 0;
    final parts = abs().toStringAsFixed(2).split('.');
    final whole = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );
    return '${isNegative ? '-' : ''}$symbol$whole.${parts[1]}';
  }

  /// Signed currency for transaction lists: "+$250.00" / "-$32.99".
  String toSignedCurrency({String symbol = AppTexts.currencySymbol}) =>
      '${this >= 0 ? '+' : '-'}${abs().toCurrency(symbol: symbol)}';
}
