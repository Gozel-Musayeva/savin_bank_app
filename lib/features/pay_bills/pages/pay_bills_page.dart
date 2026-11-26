import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_icon_tile.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/bill_category_model.dart';

/// Pay Bills: pick a bill type to open its customer-ID page.
class PayBillsPage extends StatelessWidget {
  const PayBillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.payBills, centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        child: Row(
          crossAxisAlignment: .start,
          spacing: 8.w,
          children: [
            for (final category in BillCategoryModel.values)
              Expanded(
                child: CustomIconTile(
                  icon: category.icon,
                  label: category.label,
                  onTap: () => Go.to(context, Pager.billPayment(category)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
