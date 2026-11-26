import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_button_style.dart';
import '../../core/constants/app_sizes.dart';
import 'custom_button.dart';

/// Primary button pinned to the bottom of a page (`Scaffold.bottomNavigationBar`).
/// The bottom gap is added on top of the safe-area inset, so it stays visible
/// on phones with a home indicator.
///
/// [CustomBottomButton.pair] stacks an outlined secondary button above it.
class CustomBottomButton extends StatelessWidget {
  const CustomBottomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.style,
  }) : secondaryText = null,
       onSecondaryPressed = null;

  const CustomBottomButton.pair({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    required String this.secondaryText,
    this.onSecondaryPressed,
    this.style,
  });

  final String text;
  final VoidCallback? onPressed;

  /// Spinner on the primary button while its action is in flight.
  final bool isLoading;

  /// Primary button style override (e.g. `AppButtonStyle.disabled`).
  final ButtonStyle? style;
  final String? secondaryText;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePaddingCompact.w,
          AppSizes.bottomButtonPadding.h,
          AppSizes.pagePaddingCompact.w,
          AppSizes.bottomButtonBottom.h,
        ),
        child: Column(
          mainAxisSize: .min,
          spacing: AppSizes.sheetButtonGap.h,
          children: [
            if (secondaryText case final secondary?)
              CustomButton(
                text: secondary,
                style: AppButtonStyle.outlined(context),
                onPressed: isLoading ? null : onSecondaryPressed,
              ),
            CustomButton(
              text: text,
              onPressed: onPressed,
              isLoading: isLoading,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
