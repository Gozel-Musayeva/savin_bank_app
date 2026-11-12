import 'package:flutter/material.dart';

enum TransactionType { income, expense }

enum TransactionStatus { completed, pending, failed }

enum TransactionCategory {
  shopping('Shopping', Icons.shopping_bag_outlined),
  food('Food & Drinks', Icons.restaurant_outlined),
  transport('Transport', Icons.directions_car_outlined),
  bills('Bills', Icons.receipt_long_outlined),
  entertainment('Entertainment', Icons.movie_outlined),
  salary('Salary', Icons.account_balance_wallet_outlined),
  transfer('Transfer', Icons.swap_horiz_rounded),
  health('Health', Icons.favorite_border_rounded);

  const TransactionCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    this.status = TransactionStatus.completed,
    this.cardId,
  });

  final String id;
  final String title;
  final String subtitle;

  /// Always positive — the sign comes from [type].
  final double amount;
  final DateTime date;
  final TransactionType type;
  final TransactionCategory category;
  final TransactionStatus status;
  final String? cardId;

  bool get isIncome => type == TransactionType.income;

  double get signedAmount => isIncome ? amount : -amount;

  static final transactions = [
    TransactionModel(
      id: 't1',
      title: 'Apple Store',
      subtitle: 'Shopping',
      amount: 999.00,
      date: DateTime(2026, 11, 12, 14, 5),
      type: TransactionType.expense,
      category: TransactionCategory.shopping,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't2',
      title: 'Salary',
      subtitle: 'Savin Tech LLC',
      amount: 5200.00,
      date: DateTime(2026, 11, 10, 9, 0),
      type: TransactionType.income,
      category: TransactionCategory.salary,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't3',
      title: 'Starbucks',
      subtitle: 'Food & Drinks',
      amount: 12.50,
      date: DateTime(2026, 11, 10, 8, 20),
      type: TransactionType.expense,
      category: TransactionCategory.food,
      cardId: 'c2',
    ),
    TransactionModel(
      id: 't4',
      title: 'Aysel Mammadova',
      subtitle: 'Money received',
      amount: 250.00,
      date: DateTime(2026, 11, 9, 18, 45),
      type: TransactionType.income,
      category: TransactionCategory.transfer,
    ),
    TransactionModel(
      id: 't5',
      title: 'Bolt',
      subtitle: 'Transport',
      amount: 8.40,
      date: DateTime(2026, 11, 9, 7, 55),
      type: TransactionType.expense,
      category: TransactionCategory.transport,
      cardId: 'c2',
    ),
    TransactionModel(
      id: 't6',
      title: 'Azercell',
      subtitle: 'Mobile bill',
      amount: 25.00,
      date: DateTime(2026, 11, 8, 12, 0),
      type: TransactionType.expense,
      category: TransactionCategory.bills,
      status: TransactionStatus.pending,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't7',
      title: 'Netflix',
      subtitle: 'Subscription',
      amount: 15.99,
      date: DateTime(2026, 11, 7, 0, 1),
      type: TransactionType.expense,
      category: TransactionCategory.entertainment,
      cardId: 'c2',
    ),
    TransactionModel(
      id: 't8',
      title: 'Pharmacy',
      subtitle: 'Health',
      amount: 34.20,
      date: DateTime(2026, 11, 6, 16, 30),
      type: TransactionType.expense,
      category: TransactionCategory.health,
      status: TransactionStatus.failed,
      cardId: 'c1',
    ),
  ];
}
