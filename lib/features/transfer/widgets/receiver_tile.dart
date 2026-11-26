import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/contact_model.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';

/// Saved receiver row: avatar, name, card number and a "more" icon.
class ReceiverTile extends StatelessWidget {
  const ReceiverTile({super.key, required this.receiver, this.onTap});

  final ContactModel receiver;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.receiverPaddingV.h),
        child: Row(
          spacing: 12.w,
          children: [
            CustomAvatar(
              url: receiver.avatarUrl,
              size: AppSizes.receiverAvatar,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4.h,
                children: [
                  Text(
                    receiver.name,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: AppTextStyles.bodyLargeSemiBold.copyWith(
                      color: context.colors.textPrimary,
                    ),
                  ),
                  Text(
                    receiver.cardNumber,
                    style: AppTextStyles.bodyMediumRegular.copyWith(
                      color: context.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.more_vert_rounded,
              size: AppSizes.icon.r,
              color: context.colors.icon,
            ),
          ],
        ),
      ),
    );
  }
}
