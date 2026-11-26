import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

/// Dims everything except a centred rounded square and draws white corner
/// brackets around it. Lay it over the camera view, filling the area.
class ScanOverlay extends StatelessWidget {
  const ScanOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _ScanOverlayPainter(
        window: AppSizes.scanWindow.r,
        radius: AppSizes.scanWindowRadius.r,
        corner: AppSizes.scanCornerLength.r,
        stroke: AppSizes.scanCornerStroke.r,
      ),
    );
  }

  /// The scan window's rect inside an area of [size] — lets the page place
  /// tools relative to it.
  static Rect windowIn(Size size) => Rect.fromCenter(
    center: size.center(Offset.zero),
    width: AppSizes.scanWindow.r,
    height: AppSizes.scanWindow.r,
  );
}

class _ScanOverlayPainter extends CustomPainter {
  const _ScanOverlayPainter({
    required this.window,
    required this.radius,
    required this.corner,
    required this.stroke,
  });

  final double window;
  final double radius;
  final double corner;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: window,
      height: window,
    );
    final hole = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Dim layer with the window cut out.
    canvas.drawPath(
      Path()
        ..fillType = .evenOdd
        ..addRect(Offset.zero & size)
        ..addRRect(hole),
      Paint()..color = AppColors.scanOverlay,
    );

    // Corner brackets: trace the rounded outline, keep only the corners.
    final bracket = Paint()
      ..color = AppColors.white
      ..style = .stroke
      ..strokeWidth = stroke
      ..strokeCap = .round;
    final r = radius;
    final c = corner;
    final path = Path()
      // top-left
      ..moveTo(rect.left, rect.top + c)
      ..lineTo(rect.left, rect.top + r)
      ..arcToPoint(Offset(rect.left + r, rect.top), radius: Radius.circular(r))
      ..lineTo(rect.left + c, rect.top)
      // top-right
      ..moveTo(rect.right - c, rect.top)
      ..lineTo(rect.right - r, rect.top)
      ..arcToPoint(Offset(rect.right, rect.top + r), radius: Radius.circular(r))
      ..lineTo(rect.right, rect.top + c)
      // bottom-right
      ..moveTo(rect.right, rect.bottom - c)
      ..lineTo(rect.right, rect.bottom - r)
      ..arcToPoint(
        Offset(rect.right - r, rect.bottom),
        radius: Radius.circular(r),
      )
      ..lineTo(rect.right - c, rect.bottom)
      // bottom-left
      ..moveTo(rect.left + c, rect.bottom)
      ..lineTo(rect.left + r, rect.bottom)
      ..arcToPoint(
        Offset(rect.left, rect.bottom - r),
        radius: Radius.circular(r),
      )
      ..lineTo(rect.left, rect.bottom - c);
    canvas.drawPath(path, bracket);
  }

  @override
  bool shouldRepaint(_ScanOverlayPainter old) =>
      old.window != window ||
      old.radius != radius ||
      old.corner != corner ||
      old.stroke != stroke;
}
