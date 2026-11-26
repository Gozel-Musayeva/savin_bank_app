import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_button_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/color_extensions.dart';
import '../../../core/extensions/context_extension.dart';

/// Bottom panel under the scanner: "You can also pay with" + QR Code /
/// Payment Code buttons.
class ScanPayOptions extends StatelessWidget {
  const ScanPayOptions({super.key, this.onQrCode, this.onPaymentCode});

  final VoidCallback? onQrCode;
  final VoidCallback? onPaymentCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusSheet.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSizes.pagePaddingCompact.w,
            AppSizes.scanPanelPaddingV.h,
            AppSizes.pagePaddingCompact.w,
            AppSizes.bottomButtonBottom.h,
          ),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            spacing: AppSizes.homeTitleGap.h,
            children: [
              Text(
                AppTexts.alsoPayWith,
                style: AppTextStyles.bodyLargeSemiBold.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              Row(
                spacing: AppSizes.sheetButtonGap.w,
                children: [
                  Expanded(
                    child: _option(
                      context,
                      Icons.qr_code_2_rounded,
                      AppTexts.qrCode,
                      onQrCode,
                    ),
                  ),
                  Expanded(
                    child: _option(
                      context,
                      Icons.pin_outlined,
                      AppTexts.paymentCode,
                      onPaymentCode,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _option(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onTap,
  ) => ElevatedButton.icon(
    style: AppButtonStyle.secondary(context).copyWith(
      minimumSize: Size(0, AppSizes.scanOptionButton.h).wspAll,
      foregroundColor: AppColors.primary500.wspAll,
      textStyle: AppTextStyles.bodyMediumSemiBold.wspAll,
    ),
    onPressed: onTap ?? () {},
    icon: Icon(icon, size: AppSizes.iconSmall.r),
    label: Text(label, maxLines: 1, overflow: .ellipsis),
  );
}
