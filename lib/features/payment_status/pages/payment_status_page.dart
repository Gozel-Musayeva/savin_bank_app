import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/date_time_extensions.dart';
import '../../../core/navigation/go.dart';
import '../../../common/data/models/receipt_model.dart';
import '../widgets/receipt_card.dart';

/// Receipt shown after any completed payment (transfer, bill). Sits directly on top of the
/// main shell, so Back and "Back to Home" both land on Home.
class PaymentStatusPage extends StatelessWidget {
  const PaymentStatusPage({
    super.key,
    required this.receipt,
    this.dashedDividers = false,
  });

  final ReceiptModel receipt;

  /// Passed to [ReceiptCard]: dashed (bills) vs solid (transfer).
  final bool dashedDividers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTexts.paymentStatusTitle,
        centerTitle: true,
        // No share / PDF package yet — buttons are in place for the design.
        actions: [_shareButton(context)],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        children: [
          Center(child: _successIcon(context)),
          SizedBox(height: AppSizes.statusTitleTop.h),
          Text(
            receipt.title,
            textAlign: .center,
            style: AppTextStyles.h5SemiBold.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            receipt.date.toReceiptDateTime,
            textAlign: .center,
            style: AppTextStyles.bodySmallRegular.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          SizedBox(height: AppSizes.homeSectionGap.h),
          ReceiptCard(receipt: receipt, dashedDividers: dashedDividers),
        ],
      ),
      bottomNavigationBar: CustomBottomButton.pair(
        secondaryText: AppTexts.getPdf,
        onSecondaryPressed: () {},
        text: AppTexts.backToHome,
        onPressed: () => Go.back(context),
      ),
    );
  }

  Widget _successIcon(BuildContext context) => Container(
    padding: EdgeInsets.all(AppSizes.statusIconRing.r),
    decoration: BoxDecoration(
      shape: .circle,
      color: context.colors.income.withValues(alpha: 0.2),
    ),
    child: Container(
      width: AppSizes.statusIcon.r,
      height: AppSizes.statusIcon.r,
      decoration: BoxDecoration(shape: .circle, color: context.colors.income),
      child: Icon(
        Icons.check_rounded,
        size: AppSizes.statusCheckIcon.r,
        color: AppColors.white,
      ),
    ),
  );

  Widget _shareButton(BuildContext context) => InkWell(
    onTap: () {},
    customBorder: const CircleBorder(),
    child: Container(
      width: AppSizes.iconButton.r,
      height: AppSizes.iconButton.r,
      decoration: BoxDecoration(
        shape: .circle,
        color: context.colors.surfaceVariant,
      ),
      child: Icon(
        Icons.ios_share_rounded,
        size: AppSizes.iconSmall.r,
        color: context.colors.icon,
      ),
    ),
  );
}
