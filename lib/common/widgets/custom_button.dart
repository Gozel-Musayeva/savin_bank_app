import 'package:flutter/material.dart';

import '../../core/constants/app_button_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final style = this.style ?? AppButtonStyle.primary;
    if (icon == null) {
      return ElevatedButton(
        style: style,
        onPressed: onPressed,
        child: Text(text),
      );
    }
    return ElevatedButton.icon(
      style: style,
      onPressed: onPressed,
      icon: icon,
      label: Text(text),
    );
  }
}
