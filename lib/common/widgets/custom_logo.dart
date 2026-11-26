import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/constants/app_texts.dart';
import '../../core/extensions/context_extension.dart';

/// Brand mark + "Savin Bank" wordmark, side by side.
///
/// Default (32 / 20 SemiBold) is the onboarding header;
/// [CustomLogo.large] (40 / 24 SemiBold) is the splash screen.
class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key}) : _large = false;

  const CustomLogo.large({super.key}) : _large = true;

  final bool _large;

  @override
  Widget build(BuildContext context) {
    final size = _large ? AppSizes.logoSizeLarge : AppSizes.logoSize;
    final style = _large ? AppTextStyles.h4SemiBold : AppTextStyles.h5SemiBold;
    return Row(
      mainAxisSize: .min,
      spacing: AppSizes.logoGap.w,
      children: [
        SvgPicture.asset(AppAssets.logo, width: size.r, height: size.r),
        Text(
          AppTexts.appName,
          style: style.copyWith(color: context.colors.textPrimary),
        ),
      ],
    );
  }
}
