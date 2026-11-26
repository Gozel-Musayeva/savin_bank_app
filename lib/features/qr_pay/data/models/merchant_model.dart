import '../../../../core/constants/app_assets.dart';

/// What a scanned merchant QR carries (mock — no camera yet).
class MerchantModel {
  const MerchantModel({
    required this.name,
    required this.location,
    required this.logo,
    required this.billAmount,
  });

  final String name;
  final String location;

  /// Round logo asset.
  final String logo;

  /// Amount encoded in the QR; prefills the Bill Amount field.
  final int billAmount;

  /// Digits the Bill Amount field accepts (up to Rp 999.999.999.999).
  static const int maxAmountDigits = 12;

  static const merchants = [
    MerchantModel(
      name: 'Mc Donald’s Perdatam Raya',
      location: 'South Jakarta, Indonesia',
      logo: AppAssets.merchantMcdonalds,
      billAmount: 175000,
    ),
  ];
}
