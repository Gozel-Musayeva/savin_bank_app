class AppDurations {
  AppDurations._();

  static const ms200 = Duration(milliseconds: 200);
  static const ms300 = Duration(milliseconds: 300);
  static const s1 = Duration(seconds: 1);
  static const s2 = Duration(seconds: 2);

  /// Fake network latency for mock "requests" (sign in, lookup, transfer…).
  static const mockRequest = Duration(milliseconds: 1500);
}
