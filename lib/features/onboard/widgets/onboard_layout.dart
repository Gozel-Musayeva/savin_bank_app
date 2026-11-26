import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_logo.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../data/models/onboard_model.dart';

/// Shared skeleton of the onboarding screens, laid out on the Figma frame:
/// phone mock-up → background fade → logo on top, text and buttons pinned
/// to the bottom. The fade uses the theme surface, so dark mode works too.
class OnboardLayout extends StatelessWidget {
  const OnboardLayout({super.key, required this.data, required this.actions});

  final OnboardModel data;

  /// Buttons under the title, 16 apart.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final background = context.colors.background;
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Positioned(
            left: data.imageLeft.w,
            top: data.imageTop.h,
            width: data.imageWidth.w,
            child: Image.asset(data.image, fit: .fitWidth),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    stops: [data.fadeStart, data.fadeEnd],
                    colors: [background.withValues(alpha: 0), background],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: AppSizes.onboardLogoTop.h,
            left: 0,
            right: 0,
            child: const Center(child: CustomLogo()),
          ),
          Positioned(
            left: AppSizes.pagePadding.w,
            right: AppSizes.pagePadding.w,
            bottom: data.contentBottom.h,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  AppTexts.onboardWelcome,
                  style: AppTextStyles.bodyLargeRegular.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                AppSizes.onboardTitleGap.verticalSpace,
                Text(
                  data.title,
                  style: AppTextStyles.display.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                data.actionsGap.verticalSpace,
                Column(
                  spacing: AppSizes.onboardActionsSpacing.h,
                  children: actions,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
