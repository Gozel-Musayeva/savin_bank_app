import 'package:flutter/material.dart';

enum NotificationType {
  payment(Icons.account_balance_wallet_outlined),
  scanPay(Icons.qr_code_scanner_rounded),
  discount(Icons.discount_outlined),
  deposit(Icons.local_atm_outlined);

  const NotificationType(this.icon);

  final IconData icon;
}

class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.type,
  });

  final String id;
  final String title;
  final String message;
  final DateTime date;
  final NotificationType type;

  static DateTime _ago(Duration d) => DateTime.now().subtract(d);

  static DateTime _yesterdayAt(int hour, int minute) {
    final y = DateTime.now().subtract(const Duration(days: 1));
    return DateTime(y.year, y.month, y.day, hour, minute);
  }

  /// Newest first. Dates are relative to "now" so the Today / Yesterday
  /// groups always have content.
  static final notifications = [
    NotificationModel(
      id: 'n1',
      title: 'Payment Success',
      message:
          'Your electricity bill payment in May was successful. Thank you for paying on time.',
      date: _ago(const Duration(minutes: 10)),
      type: NotificationType.payment,
    ),
    NotificationModel(
      id: 'n2',
      title: 'Payment Success',
      message: 'Your water bill payment in May was successful.',
      date: _ago(const Duration(hours: 2)),
      type: NotificationType.payment,
    ),
    NotificationModel(
      id: 'n3',
      title: 'Scan Pay Success to Subway Outlets',
      message: 'Get a big discount in this month!',
      date: _ago(const Duration(hours: 4)),
      type: NotificationType.scanPay,
    ),
    NotificationModel(
      id: 'n4',
      title: 'Extra Discount for Purchase of Travel Ticket',
      message:
          'Let’s immediately purchase your travel ticket only here and enjoy an extra discount.',
      date: _ago(const Duration(hours: 5)),
      type: NotificationType.discount,
    ),
    NotificationModel(
      id: 'n5',
      title: 'Deposit Cash Easily Without a Card',
      message:
          'Let’s deposit cash into your account easily, you don’t need a card anymore.',
      date: _yesterdayAt(21, 0),
      type: NotificationType.deposit,
    ),
    NotificationModel(
      id: 'n6',
      title: 'Payment Success',
      message:
          'Your electricity bill payment in April was successful. Thank you for paying on time.',
      date: _yesterdayAt(16, 45),
      type: NotificationType.payment,
    ),
  ];
}
