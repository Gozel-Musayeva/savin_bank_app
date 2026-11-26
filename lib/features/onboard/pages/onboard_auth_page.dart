import 'package:flutter/material.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_button_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/onboard_model.dart';
import '../widgets/onboard_layout.dart';

/// Onboard 2 — choose Sign In or Sign Up.
class OnboardAuthPage extends StatelessWidget {
  const OnboardAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardLayout(
      data: OnboardModel.second,
      actions: [
        CustomButton(
          text: AppTexts.signIn,
          onPressed: () => Go.to(context, Pager.login),
        ),
        CustomButton(
          text: AppTexts.signUp,
          style: AppButtonStyle.outlined(context),
          onPressed: () => Go.to(context, Pager.signUp),
        ),
      ],
    );
  }
}
