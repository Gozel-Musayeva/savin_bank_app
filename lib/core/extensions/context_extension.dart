import 'package:flutter/material.dart';

import '../constants/app_theme_colors.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  /// Bank-specific theme-aware colours (income, expense, surfaces, text…).
  AppThemeColors get colors => theme.extension<AppThemeColors>()!;

  bool get isDark => theme.brightness == Brightness.dark;
}
