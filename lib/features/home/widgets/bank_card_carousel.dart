import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/card_model.dart';
import '../../../common/widgets/custom_bank_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/extensions/context_extension.dart';

/// Swipeable cards with the next one peeking on the right, page dots below.
class BankCardCarousel extends StatefulWidget {
  const BankCardCarousel({super.key});

  @override
  State<BankCardCarousel> createState() => _BankCardCarouselState();
}

class _BankCardCarouselState extends State<BankCardCarousel> {
  final _controller = PageController(
    viewportFraction: AppSizes.bankCardViewport,
  );
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const cards = CardModel.cards;
    return Column(
      spacing: 12.h,
      children: [
        SizedBox(
          height: AppSizes.bankCardHeight.h,
          // Every page carries a left gap; shifting the view left by the same
          // gap lines the first card up with the page padding.
          child: Padding(
            padding: EdgeInsets.only(
              left: (AppSizes.homePadding - AppSizes.bankCardGap).w,
            ),
            child: PageView.builder(
              controller: _controller,
              padEnds: false,
              clipBehavior: .none,
              itemCount: cards.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) => Padding(
                padding: EdgeInsets.only(left: AppSizes.bankCardGap.w),
                child: CustomBankCard(card: cards[i]),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: .center,
          spacing: 4.w,
          children: [
            for (var i = 0; i < cards.length; i++) _dot(context, i == _index),
          ],
        ),
      ],
    );
  }

  Widget _dot(BuildContext context, bool active) => AnimatedContainer(
    duration: AppDurations.ms200,
    width: (active ? AppSizes.pageDotActive : AppSizes.pageDot).w,
    height: AppSizes.pageDot.r,
    decoration: BoxDecoration(
      color: active ? AppColors.primary500 : context.colors.border,
      borderRadius: BorderRadius.circular(AppSizes.pageDot.r),
    ),
  );
}
