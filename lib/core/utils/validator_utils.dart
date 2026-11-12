class ValidatorUtils {
  ValidatorUtils._();

  static final _emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  static final _digitsOnly = RegExp(r'^\d+$');

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email);

  static bool isValidPassword(String password) => password.length >= 8;

  /// 16-digit card number (spaces ignored).
  static bool isValidCardNumber(String value) {
    final digits = value.replaceAll(' ', '');
    return digits.length == 16 && _digitsOnly.hasMatch(digits);
  }

  static bool isValidAmount(String value) {
    final amount = double.tryParse(value.replaceAll(',', '.'));
    return amount != null && amount > 0;
  }
}
