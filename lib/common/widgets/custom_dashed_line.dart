import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/extensions/context_extension.dart';

/// 1px horizontal dashed separator in the border colour (receipts, bill
/// summary).
class CustomDashedLine extends StatelessWidget {
  const CustomDashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size.fromHeight(1),
      painter: _DashedPainter(
        color: context.colors.border,
        dash: AppSizes.dashWidth.w,
        gap: AppSizes.dashGap.w,
      ),
    );
  }
}

class _DashedPainter extends CustomPainter {
  const _DashedPainter({
    required this.color,
    required this.dash,
    required this.gap,
  });

  final Color color;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height;
    final y = size.height / 2;
    for (var x = 0.0; x < size.width; x += dash + gap) {
      final end = (x + dash).clamp(0.0, size.width);
      canvas.drawLine(Offset(x, y), Offset(end, y), paint);
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) =>
      old.color != color || old.dash != dash || old.gap != gap;
}
