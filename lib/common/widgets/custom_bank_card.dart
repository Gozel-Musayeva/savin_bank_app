import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/constants/app_texts.dart';
import '../../core/extensions/color_extensions.dart';
import '../../core/extensions/num_extensions.dart';
import '../../core/utils/formatter_utils.dart';
import '../data/models/card_model.dart';
import 'card_pattern_painter.dart';

/// Bank card: flat colour with a lighter square pattern, holder name + brand,
/// number, balance with an eye toggle that masks the amount. Text is white
/// in both themes.
class CustomBankCard extends StatefulWidget {
  const CustomBankCard({
    super.key,
    required this.card,
    this.height = AppSizes.bankCardHeight,
  });

  final CardModel card;

  /// Design height, scaled with `.h` (Home carousel vs My Cards list).
  final double height;

  @override
  State<CustomBankCard> createState() => _CustomBankCardState();
}

class _CustomBankCardState extends State<CustomBankCard> {
  bool _hidden = false;

  void _toggleHidden() => setState(() => _hidden = !_hidden);

  @override
  Widget build(BuildContext context) {
    final card = widget.card;
    return Container(
      height: widget.height.h,
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        color: card.color,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard.r),
      ),
      child: CustomPaint(
        painter: CardPatternPainter(
          color: card.patternColor,
          cell: AppSizes.cardPatternCell.r,
          offsetX: AppSizes.cardPatternOffsetX.r,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.bankCardPadding.r),
          child: _content(card),
        ),
      ),
    );
  }

  Widget _content(CardModel card) => Column(
    crossAxisAlignment: .start,
    mainAxisAlignment: .spaceBetween,
    children: [
      Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: _labelled(
              AppTexts.cardName,
              card.holderName,
              AppTextStyles.bodyLargeSemiBold,
            ),
          ),
          Text(
            card.brand.label,
            style: AppTextStyles.h5.copyWith(
              color: AppColors.white,
              fontStyle: .italic,
            ),
          ),
        ],
      ),
      Text(
        FormatterUtils.groupCardNumber(card.number),
        style: AppTextStyles.h5SemiBold.copyWith(
          color: AppColors.white,
          letterSpacing: 1,
        ),
      ),
      Row(
        crossAxisAlignment: .end,
        children: [
          Expanded(
            child: _labelled(
              AppTexts.balance,
              _hidden ? AppTexts.hiddenBalance : card.balance.toCurrency(),
              AppTextStyles.h4,
            ),
          ),
          GestureDetector(
            onTap: _toggleHidden,
            behavior: .opaque,
            child: SvgPicture.asset(
              _hidden ? AppAssets.eyeShow : AppAssets.eyeHide,
              width: AppSizes.icon.r,
              height: AppSizes.icon.r,
              colorFilter: AppColors.white.toColorFilter,
            ),
          ),
        ],
      ),
    ],
  );

  Widget _labelled(String label, String value, TextStyle valueStyle) => Column(
    crossAxisAlignment: .start,
    spacing: 2.h,
    children: [
      Text(
        label,
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: AppColors.white70,
        ),
      ),
      Text(
        value,
        maxLines: 1,
        overflow: .ellipsis,
        style: valueStyle.copyWith(color: AppColors.white),
      ),
    ],
  );
}
