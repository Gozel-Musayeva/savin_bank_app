import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/constants/app_texts.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/extensions/num_extensions.dart';
import '../../core/utils/formatter_utils.dart';
import '../data/models/card_model.dart';

/// Outlined card row: bank + verified badge, card number, balance, and the
/// card's artwork (or colour strip with the brand) on the right.
class CustomFundingCardTile extends StatelessWidget {
  const CustomFundingCardTile({
    super.key,
    required this.card,
    this.isSelected = false,
    this.onTap,
  });

  final CardModel card;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusMedium.r);
    return GestureDetector(
      onTap: onTap,
      behavior: .opaque,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(
            color: isSelected ? AppColors.primary500 : context.colors.border,
          ),
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: .stretch,
              children: [
                Expanded(child: _details(context)),
                SizedBox(width: AppSizes.fundingBrandWidth.w, child: _brand),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// The card's artwork when it has one, else its colour + brand name.
  Widget get _brand {
    final art = card.brandArt;
    if (art != null) return Image.asset(art, fit: .cover);
    return ColoredBox(
      color: card.color,
      child: Center(
        child: Text(
          card.brand.label,
          style: AppTextStyles.h6.copyWith(
            color: AppColors.white,
            fontStyle: .italic,
          ),
        ),
      ),
    );
  }

  Widget _details(BuildContext context) => Padding(
    padding: EdgeInsets.all(AppSizes.fundingCardPadding.r),
    child: Column(
      crossAxisAlignment: .start,
      spacing: 6.h,
      children: [
        Row(
          spacing: 6.w,
          children: [
            Flexible(
              child: Text(
                '${AppTexts.appName} (${AppTexts.fundingCurrency})',
                maxLines: 1,
                overflow: .ellipsis,
                style: AppTextStyles.bodyMediumSemiBold.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.verified_rounded,
              size: AppSizes.fundingVerifiedIcon.r,
              color: context.colors.income,
            ),
          ],
        ),
        Text(
          FormatterUtils.groupCardNumber(card.number),
          style: AppTextStyles.bodySmallRegular.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
        Text(
          card.balance.toCurrency(),
          style: AppTextStyles.bodyLargeSemiBold.copyWith(
            color: AppColors.primary500,
          ),
        ),
      ],
    ),
  );
}
