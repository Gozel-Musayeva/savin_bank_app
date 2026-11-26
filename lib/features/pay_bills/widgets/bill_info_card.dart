import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_dashed_line.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';

/// Grey rounded card holding label/value rows (Customer Details, Summary).
/// Pass [BillInfoCard.row]s, spaced automatically, and [BillInfoCard.dashed]
/// for the dashed separator above a total.
class BillInfoCard extends StatelessWidget {
  const BillInfoCard({super.key, required this.children});

  final List<Widget> children;

  static Widget row(String label, String value) =>
      _InfoRow(label: label, value: value);

  static Widget get dashed => const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.receiptPadding.r),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium.r),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: AppSizes.receiptRowGap.h,
        children: children,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
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
}

class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.dashedLinePaddingV.h),
      child: const CustomDashedLine(),
    );
  }
}
