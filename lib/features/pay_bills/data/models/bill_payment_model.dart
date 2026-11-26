import 'bill_category_model.dart';

/// A past bill payment, shown under "Recent" on a category page.
class BillPaymentModel {
  const BillPaymentModel({
    required this.category,
    required this.customerId,
    required this.amount,
    required this.date,
  });

  final BillCategoryModel category;
  final String customerId;

  /// Always positive — shown as an outgoing amount.
  final double amount;
  final DateTime date;

  /// Newest first.
  static List<BillPaymentModel> of(BillCategoryModel category) =>
      payments.where((p) => p.category == category).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  static final payments = [
    BillPaymentModel(
      category: .water,
      customerId: '2513452671892091',
      amount: 150000,
      date: DateTime(2023, 7, 2, 10, 45),
    ),
    BillPaymentModel(
      category: .water,
      customerId: '2513452671892091',
      amount: 120000,
      date: DateTime(2023, 6, 2, 10, 45),
    ),
    BillPaymentModel(
      category: .water,
      customerId: '2513452671892091',
      amount: 140000,
      date: DateTime(2023, 5, 2, 10, 45),
    ),
    BillPaymentModel(
      category: .water,
      customerId: '2513452671892091',
      amount: 150000,
      date: DateTime(2023, 4, 2, 10, 45),
    ),
    BillPaymentModel(
      category: .electricity,
      customerId: '5320018847261',
      amount: 325000,
      date: DateTime(2023, 7, 5, 9, 20),
    ),
    BillPaymentModel(
      category: .electricity,
      customerId: '5320018847261',
      amount: 298000,
      date: DateTime(2023, 6, 5, 8, 50),
    ),
    BillPaymentModel(
      category: .internet,
      customerId: '1209883471',
      amount: 375000,
      date: DateTime(2023, 7, 10, 19, 5),
    ),
    BillPaymentModel(
      category: .education,
      customerId: '20230418776',
      amount: 2500000,
      date: DateTime(2023, 7, 1, 13, 30),
    ),
  ];
}
