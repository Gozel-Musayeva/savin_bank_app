import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/constants/app_texts.dart';
import '../../core/extensions/context_extension.dart';

/// "I agree with all Terms & Conditions applied." checkbox row
/// (Add New Card, Enable Biometrics). Controlled: [value] in, [onChanged] out.
class CustomTermsCheckbox extends StatelessWidget {
  const CustomTermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.bodySmallRegularTight.copyWith(
      color: context.colors.textSecondary,
    );
    return GestureDetector(
      onTap: () => onChanged(!value),
      behavior: .opaque,
      child: Row(
        spacing: AppSizes.inputLabelGap.w,
        children: [
          SizedBox.square(
            dimension: AppSizes.iconSmall.r,
            child: Checkbox(
              value: value,
              onChanged: (v) => onChanged(v ?? false),
              activeColor: AppColors.primary500,
              side: BorderSide(color: context.colors.textTertiary),
              materialTapTargetSize: .shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: style,
                children: [
                  const TextSpan(text: AppTexts.agreePrefix),
                  TextSpan(
                    text: AppTexts.termsAndConditions,
                    style: style.copyWith(color: AppColors.primary500),
                  ),
                  const TextSpan(text: AppTexts.agreeSuffix),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
