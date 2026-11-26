import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/card_model.dart';
import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/card_pattern_painter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/utils/formatter_utils.dart';

/// Card on "Add New Card" that fills in live as the form is typed.
///
/// Empty: grey placeholder, "XXXX" digits and a bank mark.
/// [filled]: dark patterned card with the holder's name and the brand,
/// white text in both themes.
class CardPreview extends StatelessWidget {
  const CardPreview({
    super.key,
    required this.number,
    required this.expiry,
    this.filled = false,
  });

  /// Card number as typed (spaces allowed).
  final String number;

  /// Expiry as typed ("MM/YY" or partial).
  final String expiry;

  final bool filled;

  @override
  Widget build(BuildContext context) {
    final text = filled ? AppColors.white : context.colors.textPrimary;
    final label = filled ? AppColors.white70 : context.colors.textSecondary;
    return Container(
      height: AppSizes.myCardHeight.h,
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        color: filled ? AppColors.cardBlack : context.colors.placeholder,
        borderRadius: BorderRadius.circular(AppSizes.radiusCard.r),
      ),
      child: CustomPaint(
        painter: filled
            ? CardPatternPainter(
                color: AppColors.cardBlackPattern,
                cell: AppSizes.cardPatternCell.r,
                offsetX: AppSizes.cardPatternOffsetX.r,
              )
            : null,
        child: Padding(
          padding: EdgeInsets.all(AppSizes.bankCardPadding.r),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .spaceBetween,
            children: [
              Row(
                crossAxisAlignment: .start,
                children: [
                  Expanded(
                    child: _labelled(
                      AppTexts.cardName,
                      filled
                          ? UserModel.current.fullName
                          : AppTexts.cardNamePlaceholder,
                      AppTextStyles.bodyLargeMedium,
                      text: text,
                      label: label,
                    ),
                  ),
                  if (filled) _brand(text) else _bank(text),
                ],
              ),
              Text(
                _maskedNumber,
                style: AppTextStyles.h5SemiBold.copyWith(
                  color: text,
                  letterSpacing: 1,
                ),
              ),
              _labelled(
                AppTexts.cardValidThru,
                _displayExpiry,
                AppTextStyles.h5SemiBold,
                text: text,
                label: label,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _brand(Color color) => Text(
    CardBrand.visa.label,
    style: AppTextStyles.h5.copyWith(color: color, fontStyle: .italic),
  );

  Widget _bank(Color color) => Row(
    spacing: 4.w,
    children: [
      Icon(Icons.account_balance_outlined, size: AppSizes.icon.r, color: color),
      Text(
        AppTexts.cardBank,
        style: AppTextStyles.bodyLargeMedium.copyWith(color: color),
      ),
    ],
  );

  /// "4816228" → "4816 228X XXXX XXXX".
  String get _maskedNumber {
    final digits = number.replaceAll(' ', '');
    final padded = digits.padRight(
      AppSizes.cardNumberLength,
      AppTexts.cardDigitPlaceholder,
    );
    return FormatterUtils.groupCardNumber(padded);
  }

  /// "07/27" → "07 / 27"; empty → "XX / XX".
  String get _displayExpiry => expiry.isEmpty
      ? AppTexts.expiryHint
      : expiry.replaceAll(
          AppTexts.expirySeparator,
          AppTexts.expiryDisplaySeparator,
        );

  Widget _labelled(
    String title,
    String value,
    TextStyle valueStyle, {
    required Color text,
    required Color label,
  }) => Column(
    crossAxisAlignment: .start,
    spacing: 2.h,
    children: [
      Text(title, style: AppTextStyles.bodySmallRegular.copyWith(color: label)),
      Text(
        value,
        maxLines: 1,
        overflow: .ellipsis,
        style: valueStyle.copyWith(color: text),
      ),
    ],
  );
}
