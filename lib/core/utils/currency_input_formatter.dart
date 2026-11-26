import 'package:flutter/services.dart';

import '../extensions/num_extensions.dart';

/// Keeps an amount field formatted as "Rp 475.000" while typing.
class CurrencyInputFormatter extends TextInputFormatter {
  const CurrencyInputFormatter({required this.maxDigits});

  final int maxDigits;

  static final _nonDigits = RegExp(r'\D');

  /// "Rp 475.000" → 475000 (0 when empty).
  static int parse(String text) =>
      int.tryParse(text.replaceAll(_nonDigits, '')) ?? 0;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(_nonDigits, '');
    if (digits.isEmpty) return TextEditingValue.empty;
    if (digits.length > maxDigits) return oldValue;
    final text = int.parse(digits).toCurrency();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
