import 'package:flutter/material.dart';

import '../../core/constants/app_button_style.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import 'custom_loading.dart';

/// [isLoading] swaps the label for an adaptive spinner and swallows taps,
/// keeping the button's colours (no greyed-out disabled look).
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.icon,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Widget? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? AppButtonStyle.primary;
    final Widget button;
    if (isLoading) {
      button = ElevatedButton(
        style: style,
        onPressed: onPressed,
        child: _loader(context, style),
      );
    } else if (icon == null) {
      button = ElevatedButton(
        style: style,
        onPressed: onPressed,
        child: Text(text),
      );
    } else {
      button = ElevatedButton.icon(
        style: style,
        onPressed: onPressed,
        icon: icon,
        label: Text(text),
      );
    }
    return IgnorePointer(ignoring: isLoading, child: button);
  }

  Widget _loader(BuildContext context, ButtonStyle style) => CustomLoading(
    size: AppSizes.buttonLoader,
    color: style.foregroundColor?.resolve({}) ?? AppColors.white,
  );
}
