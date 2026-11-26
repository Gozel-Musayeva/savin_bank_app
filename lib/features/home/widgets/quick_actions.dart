import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/quick_action_model.dart';

/// Row of four outlined shortcut tiles (Transfer, E-Wallet, Pay Bills, More).
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  VoidCallback? _onTap(BuildContext context, QuickActionModel action) =>
      switch (action) {
        .transfer => () => Go.to(context, Pager.transfer),
        .payBills => () => Go.to(context, Pager.payBills),
        .more => () => Go.to(context, Pager.allFeatures),
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        for (final action in QuickActionModel.values)
          _item(context, action, _onTap(context, action)),
      ],
    );
  }

  Widget _item(
    BuildContext context,
    QuickActionModel action,
    VoidCallback? onTap,
  ) {
    final radius = BorderRadius.circular(AppSizes.radiusLarge.r);
    return Column(
      spacing: 8.h,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            width: AppSizes.quickActionBox.r,
            height: AppSizes.quickActionBox.r,
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: context.colors.border),
            ),
            child: Icon(
              action.icon,
              size: AppSizes.icon.r,
              color: AppColors.primary500,
            ),
          ),
        ),
        Text(
          action.label,
          style: AppTextStyles.bodySmallMedium.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
