/// Mock signed-in user. No backend — everything is static.
class UserModel {
  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.totalBalance,
    required this.monthlyIncome,
    required this.monthlyExpense,
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String avatarUrl;
  final double totalBalance;
  final double monthlyIncome;
  final double monthlyExpense;

  String get firstName => fullName.split(' ').first;

  static const current = UserModel(
    id: 'u1',
    fullName: 'Gozal Musayeva',
    email: 'gozal@savinbank.com',
    phone: '+994 50 123 45 67',
    avatarUrl: 'https://i.pravatar.cc/150?img=47',
    totalBalance: 24850.75,
    monthlyIncome: 6200.00,
    monthlyExpense: 2875.40,
  );
}
