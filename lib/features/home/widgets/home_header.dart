import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// Avatar + greeting + user name, notification bell on the right.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.user});

  final UserModel user;

  String get _greeting => switch (DateTime.now().hour) {
    < 12 => AppTexts.goodMorning,
    < 18 => AppTexts.goodAfternoon,
    _ => AppTexts.goodEvening,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: [
        CustomAvatar(url: user.avatarUrl, size: AppSizes.avatar),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 2.h,
            children: [
              Text(
                _greeting,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: context.colors.textTertiary,
                ),
              ),
              Text(
                user.fullName,
                maxLines: 1,
                overflow: .ellipsis,
                style: AppTextStyles.bodyLargeBold.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        _bell(context),
      ],
    );
  }

  Widget _bell(BuildContext context) => InkWell(
    onTap: () => Go.to(context, Pager.notification),
    customBorder: const CircleBorder(),
    child: Container(
      width: AppSizes.iconButton.r,
      height: AppSizes.iconButton.r,
      decoration: BoxDecoration(
        shape: .circle,
        border: Border.all(color: context.colors.border),
      ),
      child: Icon(
        Icons.notifications_none_rounded,
        size: AppSizes.iconSmall.r,
        color: context.colors.icon,
      ),
    ),
  );
}
