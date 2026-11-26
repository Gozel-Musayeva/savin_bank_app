import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/constants/app_texts.dart';

/// Bill types on the Pay Bills screen, in display order.
enum BillCategoryModel {
  water(
    AppTexts.water,
    AppTexts.waterBills,
    AppTexts.waterBillPayment,
    Icons.water_drop_outlined,
  ),
  electricity(
    AppTexts.electricity,
    AppTexts.electricityBills,
    AppTexts.electricityBillPayment,
    Iconsax.electricity_copy,
  ),
  internet(
    AppTexts.internet,
    AppTexts.internetBills,
    AppTexts.internetBillPayment,
    Iconsax.global_copy,
  ),
  education(
    AppTexts.education,
    AppTexts.educationBills,
    AppTexts.educationBillPayment,
    Iconsax.teacher_copy,
  );

  const BillCategoryModel(
    this.label,
    this.title,
    this.transactionName,
    this.icon,
  );

  /// Tile label on Pay Bills ("Water").
  final String label;

  /// App bar title of the category pages ("Water Bills").
  final String title;

  /// "Transaction" row in the bill summary ("Water Bill Payment").
  final String transactionName;
  final IconData icon;
}
