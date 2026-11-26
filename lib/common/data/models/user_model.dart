/// Mock signed-in user. No backend — everything is static.
class UserModel {
  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.avatarUrl,
    required this.totalBalance,
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.pin,
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;

  /// Mock credential for the Sign In screen — demo value only.
  final String password;
  final String avatarUrl;
  final double totalBalance;
  final double monthlyIncome;
  final double monthlyExpense;

  /// Mock transaction PIN (PIN screen) — demo value only. Its length sets
  /// how many boxes the PIN screen shows.
  final String pin;

  String get firstName => fullName.split(' ').first;

  /// Sign In accepts the email (any case) or the phone number (digits only
  /// are compared, so "+994 50 123 45 67" and "994501234567" both match).
  bool matches({required String username, required String password}) {
    final login = username.trim();
    final byEmail = login.toLowerCase() == email.toLowerCase();
    final byPhone =
        _digits(login).isNotEmpty && _digits(login) == _digits(phone);
    return (byEmail || byPhone) && password == this.password;
  }

  static String _digits(String value) => value.replaceAll(RegExp(r'\D'), '');

  static const current = UserModel(
    id: 'u1',
    fullName: 'Gozal Musayeva',
    email: 'gozal@savinbank.com',
    phone: '+994 50 123 45 67',
    password: 'savin123',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    totalBalance: 42525500,
    monthlyIncome: 8500000,
    monthlyExpense: 3264000,
    pin: '1234',
  );
}
