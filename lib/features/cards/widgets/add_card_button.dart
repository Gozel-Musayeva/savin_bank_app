import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';

/// Dashed rounded outline with "+ Add New Card" in brand blue.
class AddCardButton extends StatelessWidget {
  const AddCardButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = AppSizes.radiusLarge.r;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: CustomPaint(
        painter: _DashedRRectPainter(
          color: AppColors.primary300,
          radius: radius,
          dash: AppSizes.dashWidth.w,
          gap: AppSizes.dashGap.w,
        ),
        child: SizedBox(
          height: AppSizes.addCardHeight.h,
          child: Row(
            mainAxisAlignment: .center,
            spacing: 4.w,
            children: [
              Icon(
                Icons.add_rounded,
                size: AppSizes.iconSmall.r,
                color: AppColors.primary500,
              ),
              Text(
                AppTexts.addNewCard,
                style: AppTextStyles.bodyLargeMedium.copyWith(
                  color: AppColors.primary500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  const _DashedRRectPainter({
    required this.color,
    required this.radius,
    required this.dash,
    required this.gap,
  });

  final Color color;
  final double radius;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = .stroke
      ..strokeWidth = 1;
    final outline = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          (Offset.zero & size).deflate(0.5),
          Radius.circular(radius),
        ),
      );
    for (final metric in outline.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += dash + gap) {
        canvas.drawPath(metric.extractPath(d, d + dash), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRRectPainter old) =>
      old.color != color ||
      old.radius != radius ||
      old.dash != dash ||
      old.gap != gap;
}
