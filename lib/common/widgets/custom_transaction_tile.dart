import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/extensions/date_time_extensions.dart';
import '../../core/extensions/num_extensions.dart';
import '../data/models/transaction_model.dart';

/// Shared transaction row (Home, History): category icon, title +
/// Income/Outcome, signed amount + date.
class CustomTransactionTile extends StatelessWidget {
  const CustomTransactionTile({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    final secondary = AppTextStyles.bodySmallRegularTight.copyWith(
      color: context.colors.textTertiary,
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.transactionPaddingV.h),
      child: Row(
        spacing: 12.w,
        children: [
          Container(
            width: AppSizes.transactionIconBox.r,
            height: AppSizes.transactionIconBox.r,
            decoration: BoxDecoration(
              shape: .circle,
              color: context.colors.iconCircle,
            ),
            child: Icon(
              t.category.icon,
              size: AppSizes.icon.r,
              color: AppColors.primary500,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSizes.transactionTextGap.h,
              children: [
                Text(
                  t.title,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: AppTextStyles.bodyMediumSemiBold.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
                Text(t.type.label, style: secondary),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: .end,
            spacing: AppSizes.transactionTextGap.h,
            children: [
              Text(
                t.signedAmount.toSignedCurrency(),
                style: AppTextStyles.bodyLargeSemiBold.copyWith(
                  color: t.isIncome
                      ? context.colors.income
                      : AppColors.primary500,
                ),
              ),
              Text(t.date.toLongDateTime, style: secondary),
            ],
          ),
        ],
      ),
    );
  }
}
