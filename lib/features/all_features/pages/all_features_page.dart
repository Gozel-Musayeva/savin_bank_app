import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_search_input.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../data/models/feature_model.dart';
import '../widgets/feature_section.dart';

/// Every service the app offers, grouped, with a search filter.
class AllFeaturesPage extends StatefulWidget {
  const AllFeaturesPage({super.key});

  @override
  State<AllFeaturesPage> createState() => _AllFeaturesPageState();
}

class _AllFeaturesPageState extends State<AllFeaturesPage> {
  String _query = '';

  List<FeatureModel> _featuresOf(FeatureGroup group) {
    final query = _query.trim().toLowerCase();
    return FeatureModel.values
        .where((f) => f.group == group)
        .where((f) => f.label.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      for (final group in FeatureGroup.values)
        if (_featuresOf(group) case final features when features.isNotEmpty)
          FeatureSection(title: group.title, features: features),
    ];
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.featuresTitle,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: AppSizes.homeSectionGap.h,
          children: [
            CustomSearchInput(
              hintText: AppTexts.searchFeatures,
              onChanged: (value) => setState(() => _query = value),
            ),
            if (sections.isEmpty)
              Text(
                AppTexts.noFeatures,
                textAlign: .center,
                style: AppTextStyles.bodyMediumRegular.copyWith(
                  color: context.colors.textTertiary,
                ),
              )
            else
              ...sections,
          ],
        ),
      ),
    );
  }
}
