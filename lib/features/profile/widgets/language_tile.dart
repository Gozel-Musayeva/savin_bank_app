import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../data/models/language_model.dart';

/// Grey rounded row: round flag, language name, radio on the right.
class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final LanguageModel language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusInput.r);
    return Material(
      color: context.colors.surfaceVariant,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          height: AppSizes.settingsTileHeight.h,
          padding: EdgeInsets.symmetric(horizontal: AppSizes.inputPadding.w),
          child: Row(
            spacing: AppSizes.languageFlagGap.w,
            children: [
              _flag(),
              Expanded(
                child: Text(
                  language.name,
                  style: AppTextStyles.bodyMediumMedium.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              _radio(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Emoji flag scaled up and clipped to a circle, so it fills the round
  /// badge like the Figma flags.
  Widget _flag() => ClipOval(
    child: SizedBox.square(
      dimension: AppSizes.languageFlag.r,
      child: FittedBox(fit: .cover, child: Text(language.flag)),
    ),
  );

  Widget _radio(BuildContext context) => AnimatedContainer(
    duration: AppDurations.ms200,
    width: AppSizes.languageRadio.r,
    height: AppSizes.languageRadio.r,
    alignment: .center,
    decoration: BoxDecoration(
      shape: .circle,
      border: Border.all(
        color: selected ? AppColors.primary500 : context.colors.textTertiary,
        width: 1.5,
      ),
    ),
    child: selected
        ? Container(
            width: AppSizes.languageRadioDot.r,
            height: AppSizes.languageRadioDot.r,
            decoration: const BoxDecoration(
              shape: .circle,
              color: AppColors.primary500,
            ),
          )
        : null,
  );
}
