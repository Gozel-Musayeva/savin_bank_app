import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/constants/app_texts.dart';

enum FeatureGroup {
  main(AppTexts.mainFeatures),
  more(AppTexts.moreFeatures);

  const FeatureGroup(this.title);

  final String title;
}

/// Every service tile on the Features screen, in display order.
enum FeatureModel {
  transfer(AppTexts.transfer, Iconsax.convert_card_copy, FeatureGroup.main),
  eWallet(
    AppTexts.eWallet,
    Iconsax.wallet_2_copy,
    FeatureGroup.main,
  ),
  payBills(AppTexts.payBills, Iconsax.receipt_item_copy, FeatureGroup.main),
  qrPay(AppTexts.qrPay, Iconsax.scan_copy, FeatureGroup.main),
  cashWithdrawal(
    AppTexts.cashWithdrawal,
    Iconsax.wallet_money_copy,
    FeatureGroup.main,
  ),
  cashDeposit(AppTexts.cashDeposit, Iconsax.wallet_3_copy, FeatureGroup.main),
  receive(AppTexts.receive, Iconsax.money_recive_copy, FeatureGroup.main),
  donation(
    AppTexts.donation,
    Iconsax.dollar_circle_copy,
    FeatureGroup.more,
  ),
  travel(AppTexts.travel, Iconsax.airplane_copy, FeatureGroup.more),
  loanFund(
    AppTexts.loanFund,
    Iconsax.dollar_circle_copy,
    FeatureGroup.more,
  ),
  invest(
    AppTexts.invest,
    Iconsax.chart_square_copy,
    FeatureGroup.more,
  ),
  creditTopUp(
    AppTexts.creditTopUp,
    Iconsax.mobile_copy,
    FeatureGroup.more,
  ),
  insurance(
    AppTexts.insurance,
    Iconsax.briefcase_copy,
    FeatureGroup.more,
  );

  const FeatureModel(this.label, this.icon, this.group);

  final String label;
  final IconData icon;
  final FeatureGroup group;
}
