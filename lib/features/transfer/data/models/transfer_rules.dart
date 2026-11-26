/// Mock transfer limits (no backend).
class TransferRules {
  TransferRules._();

  static const int minAmount = 20000;

  /// Digits the amount field accepts (up to Rp 999.999.999.999).
  static const int maxAmountDigits = 12;

  /// Flat fee added to every transfer.
  static const int adminFee = 2500;
}
