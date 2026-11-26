import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../data/models/notification_model.dart';
import '../widgets/notification_tile.dart';

/// Notifications grouped by day ("Today", "Yesterday", then dates).
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  /// Day label → its notifications, keeping the newest-first order.
  Map<String, List<NotificationModel>> get _groups {
    final groups = <String, List<NotificationModel>>{};
    for (final n in NotificationModel.notifications) {
      groups.putIfAbsent(n.date.toDayLabel(), () => []).add(n);
    }
    return groups;
  }

  @override
  Widget build(BuildContext context) {
    final groups = _groups;
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.notificationTitle,
        centerTitle: true,
      ),
      body: groups.isEmpty
          ? Center(
              child: Text(
                AppTexts.noNotifications,
                style: AppTextStyles.bodyMediumRegular.copyWith(
                  color: context.colors.textTertiary,
                ),
              ),
            )
          : ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.pagePaddingCompact.w,
                vertical: AppSizes.homeTop.h,
              ),
              children: [
                for (final MapEntry(key: day, value: items) in groups.entries)
                  _section(context, day, items),
              ],
            ),
    );
  }

  Widget _section(
    BuildContext context,
    String day,
    List<NotificationModel> items,
  ) => Padding(
    padding: EdgeInsets.only(bottom: AppSizes.homeTop.h),
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        Text(
          day,
          style: AppTextStyles.h6.copyWith(color: context.colors.textPrimary),
        ),
        for (final n in items) ...[
          NotificationTile(notification: n),
          const Divider(height: 1),
        ],
      ],
    ),
  );
}
