import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';

/// Centered title + subtitle at the top of Sign In / Sign Up ('Welcome to
/// Savin') and Enable Biometrics.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    this.title = AppTexts.signUpTitle,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.signUpHeaderGap.h,
      children: [
        Text(
          title,
          style: AppTextStyles.h5SemiBold.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        SizedBox(
          width: AppSizes.signUpSubtitleWidth.w,
          child: Text(
            subtitle,
            textAlign: .center,
            style: AppTextStyles.bodySmallRegular.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
