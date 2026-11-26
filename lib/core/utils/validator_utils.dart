class ValidatorUtils {
  ValidatorUtils._();

  static final _emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  static final _digitsOnly = RegExp(r'^\d+$');
  static final _phoneRegex = RegExp(r'^\+?\d{10,15}$');
  static final _expiryRegex = RegExp(r'^(\d{2})/(\d{2})$');

  /// "MM/YY" (spaces ignored): month 01–12, not before the current month.
  static bool isValidExpiry(String value, {DateTime? now}) {
    final match = _expiryRegex.firstMatch(value.replaceAll(' ', ''));
    if (match == null) return false;
    final month = int.parse(match.group(1)!);
    final year = 2000 + int.parse(match.group(2)!);
    if (month < 1 || month > 12) return false;
    final today = now ?? DateTime.now();
    return year > today.year || (year == today.year && month >= today.month);
  }

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email);

  static bool isValidPassword(String password) => password.length >= 8;

  /// 10–15 digits, optional leading "+".
  static bool isValidPhone(String phone) => _phoneRegex.hasMatch(phone);

  /// 16-digit card number (spaces ignored).
  static bool isValidCardNumber(String value) {
    final digits = value.replaceAll(' ', '');
    return digits.length == 16 && _digitsOnly.hasMatch(digits);
  }

  /// Bank account number: 10–16 digits.
  static bool isValidAccountNumber(String value) =>
      _digitsOnly.hasMatch(value) && value.length >= 10 && value.length <= 16;

  static bool isValidCustomerId(String value) =>
      _digitsOnly.hasMatch(value) && value.length >= 8 && value.length <= 20;

  static bool isValidAmount(String value) {
    final amount = double.tryParse(value.replaceAll(',', '.'));
    return amount != null && amount > 0;
  }
}
