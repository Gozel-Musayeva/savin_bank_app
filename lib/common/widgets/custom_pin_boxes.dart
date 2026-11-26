import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_durations.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/extensions/context_extension.dart';

/// One box per PIN / OTP digit. Entered digits: tinted box, brand border, brand
/// dot. Empty: grey box, grey dot. [hasError] turns the borders red.
class CustomPinBoxes extends StatelessWidget {
  const CustomPinBoxes({
    super.key,
    required this.length,
    required this.filled,
    this.hasError = false,
  });

  final int length;
  final int filled;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSizes.pinBoxGap.w,
      children: [
        for (var i = 0; i < length; i++)
          Expanded(child: _box(context, isFilled: i < filled)),
      ],
    );
  }

  Widget _box(BuildContext context, {required bool isFilled}) {
    final borderColor = hasError
        ? context.colorScheme.error
        : isFilled
        ? AppColors.primary500
        : context.colors.surfaceVariant;
    return AnimatedContainer(
      duration: AppDurations.ms200,
      height: AppSizes.pinBoxHeight.h,
      alignment: .center,
      decoration: BoxDecoration(
        color: isFilled
            ? context.colorScheme.secondary
            : context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium.r),
        border: Border.all(color: borderColor),
      ),
      child: Container(
        width: AppSizes.pinDot.r,
        height: AppSizes.pinDot.r,
        decoration: BoxDecoration(
          shape: .circle,
          color: isFilled ? AppColors.primary500 : context.colors.border,
        ),
      ),
    );
  }
}
