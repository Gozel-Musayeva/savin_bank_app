import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/extensions/context_extension.dart';

/// Round network avatar with a person-icon fallback while loading / offline.
class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key, required this.url, required this.size});

  final String url;

  /// Diameter in design pixels (scaled with `.r`).
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size.r / 2,
      backgroundColor: context.colors.surfaceVariant,
      foregroundImage: NetworkImage(url),
      onForegroundImageError: (_, _) {},
      child: Icon(
        Icons.person_rounded,
        size: size.r / 2,
        color: context.colors.textTertiary,
      ),
    );
  }
}
