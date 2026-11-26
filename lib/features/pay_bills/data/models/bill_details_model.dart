import 'bill_category_model.dart';

/// What the (mock) bill lookup returns for a customer ID: who the account
/// belongs to and what is owed.
class BillDetailsModel {
  const BillDetailsModel({
    required this.category,
    required this.customerId,
    required this.customerName,
    required this.city,
    required this.bill,
    this.addCost = defaultAddCost,
  });

  /// Flat service fee added to every bill payment.
  static const int defaultAddCost = 2500;

  final BillCategoryModel category;
  final String customerId;
  final String customerName;
  final String city;
  final int bill;
  final int addCost;

  int get total => bill + addCost;

  /// Mock lookup: any valid ID resolves to the same customer, with the
  /// amount owed depending on the bill type.
  static BillDetailsModel lookup(
    BillCategoryModel category,
    String customerId,
  ) => BillDetailsModel(
    category: category,
    customerId: customerId,
    customerName: 'Olivia Vicenthie',
    city: 'South Jakarta, Indonesia',
    bill: _bills[category]!,
  );

  static const _bills = {
    BillCategoryModel.water: 150000,
    BillCategoryModel.electricity: 325000,
    BillCategoryModel.internet: 375000,
    BillCategoryModel.education: 2500000,
  };
}
