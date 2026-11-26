import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/card_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bank_card.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/add_card_button.dart';

/// Card tab: every active card stacked, then "Add New Card".
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = CardModel.cards.where((c) => !c.isFrozen).toList();
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.myCards, centerTitle: true),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        children: [
          for (final card in cards) ...[
            CustomBankCard(card: card, height: AppSizes.myCardHeight),
            SizedBox(height: AppSizes.myCardGap.h),
          ],
          AddCardButton(onTap: () => Go.to(context, Pager.addCard)),
        ],
      ),
    );
  }
}
