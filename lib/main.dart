import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_sizes.dart';
import 'core/constants/app_texts.dart';
import 'core/constants/app_themes.dart';
import 'core/cubits/theme/theme_cubit.dart';
import 'core/navigation/pager.dart';
import 'core/utils/app_scroll_behavior.dart';
import 'features/profile/cubits/language/language_cubit.dart';

void main() {
  runApp(const SavinBankApp());
}

class SavinBankApp extends StatelessWidget {
  const SavinBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LanguageCubit()),
      ],
      child: ScreenUtilInit(
        designSize: AppSizes.figmaDesignSize,
        minTextAdapt: true,
        builder: (_, child) => BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (_, themeMode) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppTexts.appName,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeMode,
            scrollBehavior: const AppScrollBehavior(),
            home: child,
          ),
        ),
        child: Pager.splash,
      ),
    );
  }
}
