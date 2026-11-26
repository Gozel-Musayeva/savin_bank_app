import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/transaction_model.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';

/// Grey pill track with an Outcome / Income segment; the selected one is a
/// raised surface-coloured pill. Controlled: value in, callback out.
class TransactionTypeTabs extends StatelessWidget {
  const TransactionTypeTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final TransactionType selected;
  final ValueChanged<TransactionType> onChanged;

  /// Outcome first, as in the design.
  static const _order = [TransactionType.expense, TransactionType.income];

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusButton.r);
    return Container(
      height: AppSizes.segmentHeight.h,
      padding: EdgeInsets.all(AppSizes.segmentPadding.r),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: radius,
      ),
      child: Row(
        children: [
          for (final type in _order)
            Expanded(child: _segment(context, type, radius)),
        ],
      ),
    );
  }

  Widget _segment(
    BuildContext context,
    TransactionType type,
    BorderRadius radius,
  ) {
    final isSelected = type == selected;
    return GestureDetector(
      onTap: () => onChanged(type),
      behavior: .opaque,
      child: AnimatedContainer(
        duration: AppDurations.ms200,
        alignment: .center,
        decoration: BoxDecoration(
          color: isSelected ? context.colors.surface : null,
          borderRadius: radius,
          boxShadow: isSelected
              ? [BoxShadow(color: context.colors.shadow, blurRadius: 8)]
              : null,
        ),
        child: Text(
          type.label,
          style:
              (isSelected
                      ? AppTextStyles.bodyMediumSemiBold
                      : AppTextStyles.bodyMediumMedium)
                  .copyWith(
                    color: isSelected
                        ? context.colors.textPrimary
                        : context.colors.textTertiary,
                  ),
        ),
      ),
    );
  }
}
