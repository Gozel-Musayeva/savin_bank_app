import 'package:flutter/material.dart';

import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';

/// "Already have an account? Sign In" / "Don’t have an account? Sign Up".
class AuthSwitchPrompt extends StatelessWidget {
  const AuthSwitchPrompt({
    super.key,
    required this.question,
    required this.action,
    required this.onTap,
  });

  final String question;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.bodySmallSemiBold;
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(
          question,
          style: style.copyWith(color: context.colors.textPrimary),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            action,
            style: style.copyWith(color: context.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
