import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../../../core/extensions/num_extensions.dart';
import '../data/models/bill_payment_model.dart';

/// Recent bill row: round category icon, customer ID + date, paid amount.
class BillPaymentTile extends StatelessWidget {
  const BillPaymentTile({super.key, required this.payment, this.onTap});

  final BillPaymentModel payment;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = payment;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.receiverPaddingV.h),
        child: Row(
          spacing: 12.w,
          children: [
            Container(
              width: AppSizes.transactionIconBox.r,
              height: AppSizes.transactionIconBox.r,
              decoration: BoxDecoration(
                shape: .circle,
                color: context.colors.surfaceVariant,
              ),
              child: Icon(
                p.category.icon,
                size: AppSizes.icon.r,
                color: AppColors.primary500,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4.h,
                children: [
                  Text(
                    p.customerId,
                    maxLines: 1,
                    overflow: .ellipsis,
                    style: AppTextStyles.bodyMediumSemiBold.copyWith(
                      color: context.colors.textPrimary,
                    ),
                  ),
                  Text(
                    p.date.toLongDateTime,
                    style: AppTextStyles.bodySmallRegular.copyWith(
                      color: context.colors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              (-p.amount).toSignedCurrency(),
              style: AppTextStyles.bodyLargeSemiBold.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
