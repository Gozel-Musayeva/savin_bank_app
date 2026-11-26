import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../cubits/language/language_cubit.dart';
import '../data/models/language_model.dart';
import '../widgets/language_tile.dart';

/// Language: one row per option, tap to select (applies immediately).
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<LanguageCubit>().state;
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.language, centerTitle: true),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        itemCount: LanguageModel.languages.length,
        separatorBuilder: (_, _) =>
            SizedBox(height: AppSizes.settingsTileGap.h),
        itemBuilder: (context, i) {
          final language = LanguageModel.languages[i];
          return LanguageTile(
            language: language,
            selected: language.code == selected.code,
            onTap: () => context.read<LanguageCubit>().select(language),
          );
        },
      ),
    );
  }
}
