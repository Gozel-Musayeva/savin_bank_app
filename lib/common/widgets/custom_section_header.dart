import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/extensions/context_extension.dart';

/// Section title with an optional trailing link ("See All").
class CustomSectionHeader extends StatelessWidget {
  const CustomSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.h6.copyWith(color: context.colors.textPrimary),
          ),
        ),
        if (actionLabel case final label?)
          GestureDetector(
            onTap: onAction,
            behavior: .opaque,
            child: Text(
              label,
              style: AppTextStyles.bodySmallSemiBold.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ),
      ],
    );
  }
}
