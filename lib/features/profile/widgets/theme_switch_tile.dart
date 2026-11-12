import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/cubits/theme/theme_cubit.dart';
import '../../../core/extensions/context_extension.dart';

/// Dark-mode on/off row. Flips the app-wide [ThemeCubit].
class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: context.isDark,
      activeThumbColor: AppColors.primary500,
      secondary: Icon(Icons.dark_mode_outlined, color: context.colors.icon),
      title: Text(
        'Dark Mode',
        style: AppTextStyles.bodyLargeSemiBold.copyWith(
          color: context.colors.textPrimary,
        ),
      ),
      onChanged: (isDark) => context.read<ThemeCubit>().setMode(
        isDark ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
