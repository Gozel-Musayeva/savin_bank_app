import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../data/models/bank_model.dart';

/// Bottom sheet listing [BankModel.banks]; the current one is ticked.
class BankPickerSheet extends StatelessWidget {
  const BankPickerSheet({super.key, this.selected});

  final BankModel? selected;

  /// Resolves to the tapped bank, `null` when dismissed.
  static Future<BankModel?> show(BuildContext context, {BankModel? selected}) =>
      showModalBottomSheet<BankModel>(
        context: context,
        barrierColor: AppColors.barrier,
        backgroundColor: context.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.radiusSheet.r),
          ),
        ),
        builder: (_) => BankPickerSheet(selected: selected),
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
            SizedBox(height: AppSizes.homeSectionGap.h),
            Text(
              AppTexts.chooseBank,
              style: AppTextStyles.h6.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            SizedBox(height: AppSizes.inputLabelGap.h),
            for (final (i, bank) in BankModel.banks.indexed) ...[
              if (i > 0) const Divider(height: 1),
              _tile(context, bank),
            ],
          ],
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, BankModel bank) {
    final isSelected = bank.id == selected?.id;
    return InkWell(
      onTap: () => Navigator.pop(context, bank),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.receiverPaddingV.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                bank.name,
                style:
                    (isSelected
                            ? AppTextStyles.bodyLargeSemiBold
                            : AppTextStyles.bodyLargeMedium)
                        .copyWith(color: context.colors.textPrimary),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_rounded,
                size: AppSizes.iconSmall.r,
                color: AppColors.primary500,
              ),
          ],
        ),
      ),
    );
  }

  Widget _handle(BuildContext context) => Container(
    width: AppSizes.sheetHandleWidth.w,
    height: AppSizes.sheetHandleHeight.h,
    decoration: BoxDecoration(
      color: context.colors.border,
      borderRadius: BorderRadius.circular(AppSizes.radiusButton),
    ),
  );
}
