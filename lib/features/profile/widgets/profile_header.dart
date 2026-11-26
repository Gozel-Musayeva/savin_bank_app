import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/card_pattern_painter.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';

/// Brand-blue patterned banner with the user's avatar, name, email and a
/// chevron. White text in both themes.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user, this.onTap});

  final UserModel user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusLarge.r);
    return Material(
      color: AppColors.cardBlue,
      borderRadius: radius,
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: onTap,
        child: CustomPaint(
          painter: CardPatternPainter(
            color: AppColors.cardBluePattern,
            cell: AppSizes.cardPatternCell.r,
            offsetX: AppSizes.cardPatternOffsetX.r,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.profileHeaderPadding.w,
              vertical: AppSizes.profileHeaderPaddingV.h,
            ),
            child: Row(
              spacing: AppSizes.profileAvatarGap.w,
              children: [
                CustomAvatar(url: user.avatarUrl, size: AppSizes.profileAvatar),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: AppSizes.profileNameGap.h,
                    children: [
                      Text(
                        user.fullName,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: AppTextStyles.bodyLargeSemiBold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        user.email,
                        maxLines: 1,
                        overflow: .ellipsis,
                        style: AppTextStyles.bodySmallRegular.copyWith(
                          color: AppColors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: AppSizes.icon.r,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
