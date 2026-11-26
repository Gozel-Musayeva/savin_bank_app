import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/extensions/context_extension.dart';

/// Figma "Search": grey pill with a leading magnifier, brand border on focus.
/// Used by Home, Features and Transfer Money.
class CustomSearchInput extends StatelessWidget {
  const CustomSearchInput({super.key, required this.hintText, this.onChanged});

  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.searchHeight.h,
      child: TextField(
        onChanged: onChanged,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        textInputAction: .search,
        textAlignVertical: .center,
        cursorColor: AppColors.primary500,
        style: AppTextStyles.bodyMediumRegular.copyWith(
          color: context.colors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodyMediumRegular.copyWith(
            color: context.colors.textSecondary,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSizes.inputPadding.w,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            size: AppSizes.iconSmall.r,
            color: context.colors.icon,
          ),
          border: _border(BorderSide.none),
          enabledBorder: _border(BorderSide.none),
          focusedBorder: _border(const BorderSide(color: AppColors.primary500)),
        ),
      ),
    );
  }

  OutlineInputBorder _border(BorderSide side) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSizes.radiusButton.r),
    borderSide: side,
  );
}
