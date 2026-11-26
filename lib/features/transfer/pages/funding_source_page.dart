import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/card_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../common/widgets/custom_funding_card_tile.dart';

/// Pick the card a transfer is paid from. Pops with the chosen [CardModel]
/// on "Choose"; Back leaves the previous choice untouched.
class FundingSourcePage extends StatefulWidget {
  const FundingSourcePage({super.key, required this.selected});

  final CardModel selected;

  @override
  State<FundingSourcePage> createState() => _FundingSourcePageState();
}

class _FundingSourcePageState extends State<FundingSourcePage> {
  late CardModel _selected = widget.selected;

  @override
  Widget build(BuildContext context) {
    final cards = CardModel.cards.where((c) => !c.isFrozen).toList();
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.fundingSource,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        itemCount: cards.length,
        separatorBuilder: (_, _) => SizedBox(height: AppSizes.sheetButtonGap.h),
        itemBuilder: (_, i) => CustomFundingCardTile(
          card: cards[i],
          isSelected: cards[i].id == _selected.id,
          onTap: () => setState(() => _selected = cards[i]),
        ),
      ),
      bottomNavigationBar: CustomBottomButton(
        text: AppTexts.choose,
        onPressed: () => Navigator.pop(context, _selected),
      ),
    );
  }
}
