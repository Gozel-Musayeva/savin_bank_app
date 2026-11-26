import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';

/// In-app number pad: 1–9, then an empty slot, 0 and backspace.
class PinKeypad extends StatelessWidget {
  const PinKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  static const _rows = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.keypadRowGap.h,
      children: [
        for (final row in _rows)
          Row(children: [for (final digit in row) _digitKey(context, digit)]),
        Row(
          children: [
            const Spacer(),
            _digitKey(context, '0'),
            _key(
              onTap: onBackspace,
              child: Icon(
                Icons.backspace_outlined,
                size: AppSizes.icon.r,
                color: context.colors.icon,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _digitKey(BuildContext context, String digit) => _key(
    onTap: () => onDigit(digit),
    child: Text(
      digit,
      style: AppTextStyles.h4Medium.copyWith(color: context.colors.textPrimary),
    ),
  );

  Widget _key({required VoidCallback onTap, required Widget child}) => Expanded(
    child: InkResponse(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      radius: AppSizes.keypadKeyHeight.r / 2,
      child: SizedBox(
        height: AppSizes.keypadKeyHeight.h,
        child: Center(child: child),
      ),
    ),
  );
}
