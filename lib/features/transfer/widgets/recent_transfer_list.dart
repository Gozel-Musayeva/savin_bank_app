import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/contact_model.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// "Recent Transfer" title + horizontally scrolling avatars with names.
class RecentTransferList extends StatelessWidget {
  const RecentTransferList({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppSizes.pagePaddingCompact.w;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSizes.homeTitleGap.h,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Text(
            AppTexts.recentTransfer,
            style: AppTextStyles.h6.copyWith(color: context.colors.textPrimary),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            crossAxisAlignment: .start,
            spacing: AppSizes.recentItemGap.w,
            children: [
              for (final contact in ContactModel.contacts)
                _item(context, contact),
            ],
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, ContactModel contact) => GestureDetector(
    onTap: () => Go.to(context, Pager.transferAmount(contact)),
    behavior: .opaque,
    child: SizedBox(
      width: AppSizes.recentItemWidth.w,
      child: Column(
        spacing: 8.h,
        children: [
          CustomAvatar(url: contact.avatarUrl, size: AppSizes.recentAvatar),
          Text(
            contact.name,
            maxLines: 1,
            overflow: .ellipsis,
            style: AppTextStyles.bodySmallMedium.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}
