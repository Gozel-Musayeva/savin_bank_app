import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_button_style.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/constants/app_texts.dart';
import '../../core/extensions/context_extension.dart';
import 'custom_button.dart';

/// Illustrated bottom sheet (Figma 103:90739): picture, title, short
/// message and a button.
///
/// One "Ok" button for results (account created, card added); pass
/// [secondaryText] for a question (Cancel | Continue side by side).
class CustomInfoSheet extends StatelessWidget {
  const CustomInfoSheet({
    super.key,
    required this.image,
    required this.title,
    required this.message,
    this.primaryText = AppTexts.ok,
    this.secondaryText,
  });

  /// Illustration asset path (`AppAssets.*`).
  final String image;
  final String title;
  final String message;
  final String primaryText;

  /// Outlined button left of the primary one; pops with `false`.
  final String? secondaryText;

  /// Resolves to `true` on the primary button, `false` on the secondary one,
  /// `null` when dismissed.
  static Future<bool?> show(
    BuildContext context, {
    required String image,
    required String title,
    required String message,
    String primaryText = AppTexts.ok,
    String? secondaryText,
  }) => showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    barrierColor: AppColors.barrier,
    backgroundColor: context.colors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.radiusSheet.r),
      ),
    ),
    builder: (_) => CustomInfoSheet(
      image: image,
      title: title,
      message: message,
      primaryText: primaryText,
      secondaryText: secondaryText,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePadding.w,
          AppSizes.sheetHandleTop.h,
          AppSizes.pagePadding.w,
          AppSizes.signUpSectionGap.h,
        ),
        child: Column(
          mainAxisSize: .min,
          children: [
            _handle(context),
            AppSizes.successSheetTop.verticalSpace,
            Image.asset(
              image,
              width: AppSizes.sheetIllustration.r,
              height: AppSizes.sheetIllustration.r,
            ),
            AppSizes.successSheetTitleTop.verticalSpace,
            Text(
              title,
              textAlign: .center,
              style: AppTextStyles.bodyLargeSemiBold.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            AppSizes.signUpHeaderGap.verticalSpace,
            SizedBox(
              width: AppSizes.successSheetMessageWidth.w,
              child: Text(
                message,
                textAlign: .center,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            AppSizes.signUpSectionGap.verticalSpace,
            _actions(context),
          ],
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    final primary = CustomButton(
      text: primaryText,
      onPressed: () => Navigator.pop(context, true),
    );
    final secondary = secondaryText;
    if (secondary == null) return primary;
    return Row(
      spacing: AppSizes.sheetButtonGap.w,
      children: [
        Expanded(
          child: CustomButton(
            text: secondary,
            style: AppButtonStyle.outlined(context),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        Expanded(child: primary),
      ],
    );
  }

  Widget _handle(BuildContext context) => Container(
    width: AppSizes.sheetHandleWidth.w,
    height: AppSizes.sheetHandleHeight.h,
    decoration: BoxDecoration(
      color: context.colors.border,
      borderRadius: BorderRadius.circular(AppSizes.radiusButton),
    ),
  );
}
