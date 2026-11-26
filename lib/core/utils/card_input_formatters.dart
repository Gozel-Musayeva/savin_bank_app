import 'package:flutter/services.dart';

import '../constants/app_sizes.dart';
import '../constants/app_texts.dart';
import 'formatter_utils.dart';

final _nonDigits = RegExp(r'\D');

/// Keeps a card-number field as "4816 2283 …": digits only, grouped by 4,
/// capped at 16 digits.
class CardNumberInputFormatter extends TextInputFormatter {
  const CardNumberInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(_nonDigits, '');
    if (digits.length > AppSizes.cardNumberLength) return oldValue;
    final text = FormatterUtils.groupCardNumber(digits);
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// Keeps an expiry field as "MM/YY" while typing (max 4 digits).
class ExpiryInputFormatter extends TextInputFormatter {
  const ExpiryInputFormatter();

  static const _maxDigits = 4;
  static const _monthDigits = 2;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(_nonDigits, '');
    if (digits.length > _maxDigits) return oldValue;
    // Backspace over the separator removes the month's last digit too.
    final deletingSeparator =
        newValue.text.length < oldValue.text.length &&
        oldValue.text.endsWith(AppTexts.expirySeparator);
    if (deletingSeparator && digits.length == _monthDigits) {
      digits = digits.substring(0, 1);
    }
    final text = digits.length < _monthDigits
        ? digits
        : '${digits.substring(0, _monthDigits)}${AppTexts.expirySeparator}'
              '${digits.substring(_monthDigits)}';
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
