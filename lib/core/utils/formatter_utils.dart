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

  /// "4532123456781234" → "**** **** **** 1234"
  static String maskCardNumber(String number) {
    final digits = number.replaceAll(' ', '');
    final last4 = digits.substring(digits.length - 4);
    return '**** **** **** $last4';
  }
}
