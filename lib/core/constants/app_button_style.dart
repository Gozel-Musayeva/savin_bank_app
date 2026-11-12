import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/color_extensions.dart';
import '../extensions/context_extension.dart';
import 'app_colors.dart';
import 'app_sizes.dart';
import 'app_text_style.dart';

class AppButtonStyle {
  AppButtonStyle._();

  static ButtonStyle get primary => ButtonStyle(
    backgroundColor: AppColors.primary500.wspAll,
    foregroundColor: AppColors.white.wspAll,
    textStyle: AppTextStyles.bodyLargeBold.wspAll,
    minimumSize: Size(double.infinity, 56.h).wspAll,
    elevation: 0.0.wspAll,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusButton),
    ).wspAll,
  );

  static ButtonStyle secondary(BuildContext context) => primary.copyWith(
    backgroundColor: context.colorScheme.secondary.wspAll,
    foregroundColor: context.colorScheme.onSecondary.wspAll,
  );

  static ButtonStyle get small => primary.copyWith(
    minimumSize: Size(80.w, 36.h).wspAll,
    textStyle: AppTextStyles.bodyMediumSemiBold.wspAll,
  );

  static ButtonStyle outlined(BuildContext context) => primary.copyWith(
    backgroundColor: AppColors.transparent.wspAll,
    foregroundColor: AppColors.primary500.wspAll,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusButton),
      side: const BorderSide(color: AppColors.primary500, width: 1.5),
    ).wspAll,
  );
}
