import '../constants/app_texts.dart';

class FormatterUtils {
  FormatterUtils._();

  /// "4532123456781234" → "4532 1234 5678 1234"
  static String groupCardNumber(String number) {
    final digits = number.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  /// "+994 50 123 45 67" → "9945012*****": digits only, the first
  /// [visible] kept, the rest hidden.
  static String maskPhone(String phone, {int visible = 7}) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    final shown = digits.length > visible
        ? digits.substring(0, visible)
        : digits;
    return '$shown${AppTexts.phoneMask}';
  }

  /// "4532123456781234" → "**** **** **** 1234"
  static String maskCardNumber(String number) {
    final digits = number.replaceAll(' ', '');
    final last4 = digits.substring(digits.length - 4);
    return '**** **** **** $last4';
  }
}
