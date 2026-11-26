import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/extensions/color_extensions.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../qr_pay/data/models/merchant_model.dart';
import '../widgets/scan_overlay.dart';
import '../widgets/scan_pay_options.dart';

/// QR Pay scanner. UI only: no camera package yet, so a dark placeholder
/// stands in for the feed. Gallery, flash, QR Code and Payment Code have no
/// flows yet.
class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Light status-bar icons over the dark camera area.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.scanCamera,
        body: Column(
          children: [
            Expanded(child: _scanner(context)),
            const ScanPayOptions(),
          ],
        ),
      ),
    );
  }

  Widget _scanner(BuildContext context) => Stack(
    children: [
      // No camera yet: tapping the scanner stands in for a successful scan.
      Positioned.fill(
        child: GestureDetector(
          onTap: () =>
              Go.replace(context, Pager.qrPay(MerchantModel.merchants.first)),
          child: const ScanOverlay(),
        ),
      ),
      SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pagePaddingCompact.w,
            vertical: AppSizes.homeTop.h,
          ),
          child: Row(
            children: [
              _roundButton(AppAssets.arrowLeft, () => Go.back(context)),
              const Spacer(),
              _roundButton(AppAssets.flash, () {}),
            ],
          ),
        ),
      ),
      // Bottom-right of the camera area, right-aligned with the flash button.
      Positioned(
        right: AppSizes.pagePaddingCompact.w,
        bottom: AppSizes.scanGalleryBottom.h,
        child: _roundButton(AppAssets.galleryAdd, () {}),
      ),
    ],
  );

  Widget _roundButton(String icon, VoidCallback onTap) => Material(
    color: AppColors.scanButton,
    shape: const CircleBorder(),
    clipBehavior: .antiAlias,
    child: InkWell(
      onTap: onTap,
      child: SizedBox.square(
        dimension: AppSizes.iconButton.r,
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: AppSizes.icon.r,
            height: AppSizes.icon.r,
            colorFilter: AppColors.scanButtonIcon.toColorFilter,
          ),
        ),
      ),
    ),
  );
}
