import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/receipt_model.dart';
import '../../../common/widgets/custom_dashed_line.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/num_extensions.dart';

/// Grey receipt card: ref number + flow details, then amount + fee, then
/// the total. [dashedDividers] picks dashed (bills) or solid (transfer)
/// separators between the blocks.
class ReceiptCard extends StatelessWidget {
  const ReceiptCard({
    super.key,
    required this.receipt,
    this.dashedDividers = false,
  });

  final ReceiptModel receipt;
  final bool dashedDividers;

  @override
  Widget build(BuildContext context) {
    final r = receipt;
    final gap = SizedBox(height: AppSizes.receiptRowGap.h);
    final lines = [ReceiptLine(AppTexts.refNumber, r.refNumber), ...r.details];
    return Container(
      padding: EdgeInsets.all(AppSizes.receiptPadding.r),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium.r),
      ),
      child: Column(
        children: [
          for (final (i, line) in lines.indexed) ...[
            if (i > 0) gap,
            _row(context, line.label, line.value),
          ],
          _divider(context),
          _row(context, AppTexts.amount, r.amount.toCurrency()),
          gap,
          _row(context, AppTexts.adminFee, r.fee.toCurrency()),
          _divider(context),
          _row(context, AppTexts.total, r.total.toCurrency()),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: AppSizes.receiptPadding.h),
    child: dashedDividers
        ? const CustomDashedLine()
        : Divider(height: 1, color: context.colors.border),
  );

  Widget _row(BuildContext context, String label, String value) => Row(
    spacing: 12.w,
    children: [
      Text(
        label,
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: context.colors.textSecondary,
        ),
      ),
      Expanded(
        child: Text(
          value,
          textAlign: .end,
          maxLines: 1,
          overflow: .ellipsis,
          style: AppTextStyles.bodyMediumSemiBold.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
      ),
    ],
  );
}
