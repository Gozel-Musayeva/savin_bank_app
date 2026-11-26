import 'package:flutter/material.dart';

import '../../../../core/constants/app_texts.dart';

/// Shortcut buttons under the card carousel.
enum QuickActionModel {
  transfer(AppTexts.transfer, Icons.swap_horiz_rounded),
  eWallet(AppTexts.eWallet, Icons.account_balance_wallet_outlined),
  payBills(AppTexts.payBills, Icons.receipt_long_outlined),
  more(AppTexts.more, Icons.grid_view_rounded);

  const QuickActionModel(this.label, this.icon);

  final String label;
  final IconData icon;
}
