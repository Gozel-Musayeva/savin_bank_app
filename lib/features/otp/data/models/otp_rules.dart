/// Mock OTP check (Add New Card, Change Email — no backend).
class OtpRules {
  OtpRules._();

  /// The code the "bank" sends — demo value only. Its length sets how many
  /// boxes the OTP screen shows.
  static const code = '1234';

  /// Wait before "Resend" can be used again.
  static const resendAfter = Duration(minutes: 2, seconds: 45);
}
