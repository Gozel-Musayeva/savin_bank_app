import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';

/// Grey rounded row on the Account page: icon, label, and one trailing part.
///
/// - [SettingsTile.new] — chevron, opens something on tap.
/// - [SettingsTile.toggle] — switch; tapping the row flips it too.
/// - [SettingsTile.value] — read-only text on the right (e.g. app version).
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : value = null,
       switchValue = null,
       onChanged = null;

  const SettingsTile.toggle({
    super.key,
    required this.icon,
    required this.label,
    required bool this.switchValue,
    required ValueChanged<bool> this.onChanged,
  }) : value = null,
       onTap = null;

  const SettingsTile.value({
    super.key,
    required this.icon,
    required this.label,
    required String this.value,
  }) : switchValue = null,
       onChanged = null,
       onTap = null;

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? value;
  final bool? switchValue;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.radiusInput.r);
    final tap = switch ((switchValue, onChanged)) {
      (final v?, final change?) => () => change(!v),
      _ => onTap,
    };
    return Material(
      color: context.colors.surfaceVariant,
      borderRadius: radius,
      child: InkWell(
        onTap: tap,
        borderRadius: radius,
        child: Container(
          height: AppSizes.settingsTileHeight.h,
          padding: EdgeInsets.symmetric(horizontal: AppSizes.inputPadding.w),
          child: Row(
            spacing: AppSizes.settingsIconGap.w,
            children: [
              // Figma: 24 icon centred in a 38 box, label 12 after it.
              SizedBox.square(
                dimension: AppSizes.settingsIconBox.r,
                child: Icon(
                  icon,
                  size: AppSizes.icon.r,
                  color: context.colors.icon,
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.bodyMediumMedium.copyWith(
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              _trailing(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trailing(BuildContext context) {
    if (switchValue case final on?) {
      // Figma toggle is 40×24; the Material switch is scaled down to fit.
      return SizedBox(
        width: AppSizes.settingsToggleWidth.r,
        height: AppSizes.settingsToggleHeight.r,
        child: FittedBox(
          child: Switch(
            value: on,
            onChanged: onChanged,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.success500,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: context.colors.border,
            trackOutlineColor: const WidgetStatePropertyAll(
              AppColors.transparent,
            ),
            materialTapTargetSize: .shrinkWrap,
          ),
        ),
      );
    }
    if (value case final text?) {
      return Text(
        text,
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: context.colors.textSecondary,
        ),
      );
    }
    return Icon(
      Icons.chevron_right_rounded,
      size: AppSizes.icon.r,
      color: context.colors.icon,
    );
  }
}
