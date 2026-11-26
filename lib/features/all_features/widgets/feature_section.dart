import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_icon_tile.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/feature_model.dart';

/// Group title + a 4-column grid of [CustomIconTile]s. Rows are built by hand
/// (not a GridView) so a two-line label simply makes its row taller.
class FeatureSection extends StatelessWidget {
  const FeatureSection({
    super.key,
    required this.title,
    required this.features,
  });

  final String title;
  final List<FeatureModel> features;

  static final _columns = AppSizes.featureColumns.toInt();

  VoidCallback? _onTap(BuildContext context, FeatureModel feature) =>
      switch (feature) {
        .transfer => () => Go.to(context, Pager.transfer),
        .payBills => () => Go.to(context, Pager.payBills),
        .qrPay => () => Go.to(context, Pager.qrScan),
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSizes.homeTitleGap.h,
      children: [
        Text(
          title,
          style: AppTextStyles.h6.copyWith(color: context.colors.textPrimary),
        ),
        for (var start = 0; start < features.length; start += _columns)
          Padding(
            padding: EdgeInsets.only(
              bottom: start + _columns < features.length
                  ? (AppSizes.featureRowGap - AppSizes.homeTitleGap).h
                  : 0,
            ),
            child: Row(
              crossAxisAlignment: .start,
              spacing: 8.w,
              children: [
                for (var i = start; i < start + _columns; i++)
                  Expanded(
                    child: i < features.length
                        ? CustomIconTile(
                            icon: features[i].icon,
                            label: features[i].label,
                            onTap: _onTap(context, features[i]),
                          )
                        : const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
