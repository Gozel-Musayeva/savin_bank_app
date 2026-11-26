import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/extensions/context_extension.dart';

/// Round tinted icon with a (up to two-line) label under it — service grids
/// on Features and Pay Bills.
class CustomIconTile extends StatelessWidget {
  const CustomIconTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: .opaque,
      child: Column(
        spacing: AppSizes.featureLabelGap.h,
        children: [
          Container(
            width: AppSizes.featureIconBox.r,
            height: AppSizes.featureIconBox.r,
            decoration: BoxDecoration(
              shape: .circle,
              color: context.colors.iconCircle,
            ),
            child: Icon(
              icon,
              size: AppSizes.icon.r,
              color: AppColors.primary500,
            ),
          ),
          Text(
            label,
            textAlign: .center,
            maxLines: 2,
            overflow: .ellipsis,
            style: AppTextStyles.bodySmallMedium.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
