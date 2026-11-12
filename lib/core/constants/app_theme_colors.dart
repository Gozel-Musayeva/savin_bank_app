import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Bank-specific semantic colours that `ColorScheme` has no slot for.
/// Registered on both themes, read with `context.colors.<name>`.
@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.icon,
    required this.income,
    required this.expense,
    required this.warning,
    required this.navBarBackground,
    required this.navBarInactive,
    required this.shadow,
  });

  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color icon;
  final Color income;
  final Color expense;
  final Color warning;
  final Color navBarBackground;
  final Color navBarInactive;
  final Color shadow;

  static const light = AppThemeColors(
    background: AppColors.greyScale50,
    surface: AppColors.white,
    surfaceVariant: AppColors.greyScale100,
    border: AppColors.greyScale200,
    textPrimary: AppColors.greyScale900,
    textSecondary: AppColors.greyScale700,
    textTertiary: AppColors.greyScale500,
    icon: AppColors.greyScale900,
    income: AppColors.success500,
    expense: AppColors.error500,
    warning: AppColors.warning500,
    navBarBackground: AppColors.white,
    navBarInactive: AppColors.greyScale500,
    shadow: Color(0x14000000),
  );

  static const dark = AppThemeColors(
    background: AppColors.dark1,
    surface: AppColors.dark2,
    surfaceVariant: AppColors.dark3,
    border: AppColors.dark4,
    textPrimary: AppColors.white,
    textSecondary: AppColors.greyScale300,
    textTertiary: AppColors.greyScale500,
    icon: AppColors.white,
    income: AppColors.success500,
    expense: AppColors.error500,
    warning: AppColors.warning500,
    navBarBackground: AppColors.dark2,
    navBarInactive: AppColors.greyScale600,
    shadow: Color(0x40000000),
  );

  @override
  AppThemeColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? icon,
    Color? income,
    Color? expense,
    Color? warning,
    Color? navBarBackground,
    Color? navBarInactive,
    Color? shadow,
  }) => AppThemeColors(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    surfaceVariant: surfaceVariant ?? this.surfaceVariant,
    border: border ?? this.border,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textTertiary: textTertiary ?? this.textTertiary,
    icon: icon ?? this.icon,
    income: income ?? this.income,
    expense: expense ?? this.expense,
    warning: warning ?? this.warning,
    navBarBackground: navBarBackground ?? this.navBarBackground,
    navBarInactive: navBarInactive ?? this.navBarInactive,
    shadow: shadow ?? this.shadow,
  );

  @override
  AppThemeColors lerp(AppThemeColors? other, double t) {
    if (other == null) return this;
    return AppThemeColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      navBarBackground: Color.lerp(
        navBarBackground,
        other.navBarBackground,
        t,
      )!,
      navBarInactive: Color.lerp(navBarInactive, other.navBarInactive, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}
