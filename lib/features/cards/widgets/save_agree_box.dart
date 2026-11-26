import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_terms_checkbox.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';

/// "Save & Agree" panel: short notice plus the Terms & Conditions checkbox.
/// Controlled: [value] in, [onChanged] out.
class SaveAgreeBox extends StatelessWidget {
  const SaveAgreeBox({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final secondary = AppTextStyles.bodySmallRegular.copyWith(
      color: context.colors.textSecondary,
    );
    return Container(
      padding: EdgeInsets.all(AppSizes.inputPadding.r),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSizes.radiusInput.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSizes.inputLabelGap.h,
        children: [
          Text(
            AppTexts.saveAgreeTitle,
            style: AppTextStyles.bodyMediumSemiBold.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          Text(AppTexts.saveAgreeMessage, style: secondary),
          // Figma: thin rule between the notice and the checkbox.
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.agreeDividerGap.h),
            child: Divider(height: 1, color: context.colors.border),
          ),
          CustomTermsCheckbox(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
