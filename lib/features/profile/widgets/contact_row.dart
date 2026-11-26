import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../data/models/contact_channel_model.dart';

/// Label above a grey rounded row holding the value and a chevron.
class ContactRow extends StatelessWidget {
  const ContactRow({super.key, required this.channel, required this.onTap});

  final ContactChannelModel channel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusInput.r);
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSizes.inputLabelGap.h,
      children: [
        Text(
          channel.label,
          style: AppTextStyles.bodyMediumSemiBold.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        Material(
          color: context.colors.surfaceVariant,
          borderRadius: radius,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.inputPadding.w,
                vertical: AppSizes.inputPasswordPaddingV.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      channel.value,
                      maxLines: 1,
                      overflow: .ellipsis,
                      style: AppTextStyles.bodySmallRegularTight.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: AppSizes.inputIcon.r,
                    color: context.colors.icon,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
