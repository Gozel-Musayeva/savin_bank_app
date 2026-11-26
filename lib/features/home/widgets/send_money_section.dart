import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/contact_model.dart';
import '../../../common/widgets/custom_section_header.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// "Send Money" title + horizontally scrolling "Add" button and contacts.
class SendMoneySection extends StatelessWidget {
  const SendMoneySection({super.key});

  void _openTransfer(BuildContext context) => Go.to(context, Pager.transfer);

  @override
  Widget build(BuildContext context) {
    final padding = AppSizes.homePadding.w;
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSizes.homeTitleGap.h,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: const CustomSectionHeader(title: AppTexts.sendMoney),
        ),
        SingleChildScrollView(
          scrollDirection: .horizontal,
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            crossAxisAlignment: .start,
            spacing: 12.w,
            children: [
              _item(context, label: AppTexts.add, avatar: _addButton(context)),
              for (final contact in ContactModel.contacts)
                _item(
                  context,
                  label: contact.firstName,
                  avatar: CustomAvatar(
                    url: contact.avatarUrl,
                    size: AppSizes.contactAvatar,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _item(
    BuildContext context, {
    required String label,
    required Widget avatar,
  }) => GestureDetector(
    onTap: () => _openTransfer(context),
    behavior: .opaque,
    child: SizedBox(
      width: AppSizes.contactWidth.w,
      child: Column(
        spacing: 8.h,
        children: [
          avatar,
          Text(
            label,
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

  Widget _addButton(BuildContext context) => Container(
    width: AppSizes.contactAvatar.r,
    height: AppSizes.contactAvatar.r,
    decoration: BoxDecoration(
      shape: .circle,
      border: Border.all(color: context.colors.border),
    ),
    child: Icon(
      Icons.add_rounded,
      size: AppSizes.icon.r,
      color: AppColors.primary500,
    ),
  );
}
