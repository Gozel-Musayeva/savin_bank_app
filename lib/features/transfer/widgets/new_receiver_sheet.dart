import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/contact_model.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_button_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../data/models/bank_model.dart';

/// "New Receiver" confirmation: who the account belongs to, Next / Cancel.
class NewReceiverSheet extends StatelessWidget {
  const NewReceiverSheet({
    super.key,
    required this.receiver,
    required this.bank,
    required this.number,
  });

  final ContactModel receiver;
  final BankModel bank;
  final String number;

  /// Resolves to `true` on Next, `null` on Cancel / dismiss.
  static Future<bool?> show(
    BuildContext context, {
    required ContactModel receiver,
    required BankModel bank,
    required String number,
  }) => showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    barrierColor: AppColors.barrier,
    backgroundColor: context.colors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.radiusSheet.r),
      ),
    ),
    builder: (_) =>
        NewReceiverSheet(receiver: receiver, bank: bank, number: number),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePaddingCompact.w,
          AppSizes.sheetHandleTop.h,
          AppSizes.pagePaddingCompact.w,
          AppSizes.bottomButtonBottom.h,
        ),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            Center(child: _handle(context)),
            SizedBox(height: AppSizes.homeTitleGap.h),
            Text(
              AppTexts.newReceiverSheetTitle,
              textAlign: .center,
              style: AppTextStyles.bodyLargeSemiBold.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            SizedBox(height: AppSizes.homeTitleGap.h),
            _receiverCard(context),
            SizedBox(height: AppSizes.homeSectionGap.h),
            CustomButton(
              text: AppTexts.next,
              onPressed: () => Navigator.pop(context, true),
            ),
            SizedBox(height: AppSizes.sheetButtonGap.h),
            CustomButton(
              text: AppTexts.cancel,
              style: AppButtonStyle.outlined(context),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _receiverCard(BuildContext context) => Container(
    padding: EdgeInsets.all(AppSizes.receiverCardPadding.r),
    decoration: BoxDecoration(
      color: context.colors.surfaceVariant,
      borderRadius: BorderRadius.circular(AppSizes.radiusLarge.r),
    ),
    child: Column(
      spacing: 8.h,
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.receiverCardRing.r),
          decoration: BoxDecoration(
            shape: .circle,
            color: context.colorScheme.secondary,
          ),
          child: CustomAvatar(
            url: receiver.avatarUrl,
            size: AppSizes.receiverCardAvatar,
          ),
        ),
        Text(
          receiver.name,
          textAlign: .center,
          style: AppTextStyles.bodyMediumBold.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        Text(
          '${bank.name} - $number',
          textAlign: .center,
          style: AppTextStyles.bodySmallRegular.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    ),
  );

  Widget _handle(BuildContext context) => Container(
    width: AppSizes.sheetHandleWidth.w,
    height: AppSizes.sheetHandleHeight.h,
    decoration: BoxDecoration(
      color: context.colors.border,
      borderRadius: BorderRadius.circular(AppSizes.radiusButton),
    ),
  );
}
