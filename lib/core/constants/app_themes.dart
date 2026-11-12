import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_style.dart';
import 'app_theme_colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get lightTheme => _build(
    brightness: Brightness.light,
    colors: AppThemeColors.light,
    secondary: AppColors.primary50,
    onSecondary: AppColors.primary500,
  );

  static ThemeData get darkTheme => _build(
    brightness: Brightness.dark,
    colors: AppThemeColors.dark,
    secondary: AppColors.dark3,
    onSecondary: AppColors.white,
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppThemeColors colors,
    required Color secondary,
    required Color onSecondary,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary500,
      brightness: brightness,
      primary: AppColors.primary500,
      onPrimary: AppColors.white,
      secondary: secondary,
      onSecondary: onSecondary,
      error: AppColors.error500,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      outline: colors.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Urbanist',
      colorScheme: colorScheme,
      primaryColor: AppColors.primary500,
      scaffoldBackgroundColor: colors.background,
      extensions: [colors],
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.h3.copyWith(color: colors.textPrimary),
        headlineMedium: AppTextStyles.h4.copyWith(color: colors.textPrimary),
        headlineSmall: AppTextStyles.h5.copyWith(color: colors.textPrimary),
        titleLarge: AppTextStyles.h6.copyWith(color: colors.textPrimary),
        titleMedium: AppTextStyles.bodyLargeSemiBold.copyWith(
          color: colors.textPrimary,
        ),
        bodyLarge: AppTextStyles.bodyLargeRegular.copyWith(
          color: colors.textSecondary,
        ),
        bodyMedium: AppTextStyles.bodyMediumRegular.copyWith(
          color: colors.textSecondary,
        ),
        bodySmall: AppTextStyles.bodySmallRegular.copyWith(
          color: colors.textTertiary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.h5.copyWith(color: colors.textPrimary),
        iconTheme: IconThemeData(color: colors.icon),
      ),
      iconTheme: IconThemeData(color: colors.icon),
      dividerTheme: DividerThemeData(color: colors.border, thickness: 1),
      cardTheme: CardThemeData(
        color: colors.surface,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceVariant,
        hintStyle: AppTextStyles.bodyMediumRegular.copyWith(
          color: colors.textTertiary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary500),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error500),
        ),
      ),
    );
  }
}
