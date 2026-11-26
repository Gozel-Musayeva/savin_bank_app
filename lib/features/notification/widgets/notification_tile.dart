import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../data/models/notification_model.dart';

/// Type icon, title, one-line message and relative time.
class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final n = notification;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.notificationPaddingV.h),
      child: Row(
        crossAxisAlignment: .start,
        spacing: AppSizes.notificationIconGap.w,
        children: [
          Icon(n.type.icon, size: AppSizes.icon.r, color: AppColors.primary500),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSizes.notificationTextGap.h,
              children: [
                Text(
                  n.title,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: AppTextStyles.bodyLargeSemiBold.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(
                  n.message,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
                Text(
                  n.date.toRelativeTime(),
                  style: AppTextStyles.bodyXSmallRegular.copyWith(
                    color: context.colors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
