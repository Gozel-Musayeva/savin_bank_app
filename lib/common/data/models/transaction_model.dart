import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

enum TransactionType {
  income('Income'),
  expense('Outcome');

  const TransactionType(this.label);

  final String label;
}

enum TransactionStatus { completed, pending, failed }

enum TransactionCategory {
  topUp('Top Up', Iconsax.wallet_2_copy),
  shopping('Shopping', Iconsax.shopping_bag_copy),
  food('Food & Drinks', Iconsax.coffee_copy),
  transport('Transport', Iconsax.car_copy),
  bills('Bills', Iconsax.receipt_item_copy),
  electricity('Electricity', Iconsax.electricity_copy),
  water('Water', Icons.water_drop_outlined),
  qrPay('QR Pay', Iconsax.scan_copy),
  entertainment('Entertainment', Iconsax.video_play_copy),
  salary('Salary', Iconsax.money_copy),
  transfer('Transfer', Iconsax.convert_card_copy),
  health('Health', Iconsax.heart_copy);

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

  /// Newest first.
  static final transactions = [
    TransactionModel(
      id: 't1',
      title: 'E-Wallet Topup',
      subtitle: 'GoPay',
      amount: 75000,
      date: DateTime(2026, 11, 14, 16, 45),
      type: TransactionType.expense,
      category: TransactionCategory.topUp,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't2',
      title: 'Transfer to Aysel',
      subtitle: 'Aysel Mammadova',
      amount: 250000,
      date: DateTime(2026, 11, 14, 12, 10),
      type: TransactionType.expense,
      category: TransactionCategory.transfer,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't3',
      title: 'Pay Electricity Bills',
      subtitle: 'PLN',
      amount: 150000,
      date: DateTime(2026, 11, 13, 9, 30),
      type: TransactionType.expense,
      category: TransactionCategory.electricity,
      cardId: 'c2',
    ),
    TransactionModel(
      id: 't4',
      title: 'E-Wallet Topup',
      subtitle: 'OVO',
      amount: 235000,
      date: DateTime(2026, 11, 12, 18, 5),
      type: TransactionType.expense,
      category: TransactionCategory.topUp,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't7',
      title: 'Pay Water Bills',
      subtitle: 'PDAM',
      amount: 135000,
      date: DateTime(2026, 11, 11, 16, 45),
      type: TransactionType.expense,
      category: TransactionCategory.water,
      cardId: 'c2',
    ),
    TransactionModel(
      id: 't8',
      title: 'QR Pay to Kidstation',
      subtitle: 'Kidstation',
      amount: 235000,
      date: DateTime(2026, 11, 11, 12, 17),
      type: TransactionType.expense,
      category: TransactionCategory.qrPay,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't9',
      title: 'Transfer from Huseyn',
      subtitle: 'Huseyn Aliyev',
      amount: 500000,
      date: DateTime(2026, 11, 10, 20, 30),
      type: TransactionType.income,
      category: TransactionCategory.transfer,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't5',
      title: 'Salary',
      subtitle: 'Savin Tech LLC',
      amount: 8500000,
      date: DateTime(2026, 11, 10, 9, 0),
      type: TransactionType.income,
      category: TransactionCategory.salary,
      cardId: 'c1',
    ),
    TransactionModel(
      id: 't6',
      title: 'Netflix',
      subtitle: 'Subscription',
      amount: 54000,
      date: DateTime(2026, 11, 7, 0, 1),
      type: TransactionType.expense,
      category: TransactionCategory.entertainment,
      status: TransactionStatus.pending,
      cardId: 'c2',
    ),
    TransactionModel(
      id: 't10',
      title: 'Cashback Reward',
      subtitle: 'Savin Bank',
      amount: 25000,
      date: DateTime(2026, 11, 5, 10, 15),
      type: TransactionType.income,
      category: TransactionCategory.topUp,
      cardId: 'c1',
    ),
  ];
}
