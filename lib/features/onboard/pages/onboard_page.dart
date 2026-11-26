import 'package:flutter/material.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/onboard_model.dart';
import '../widgets/onboard_layout.dart';

/// Onboard 1 — "Get Started".
class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardLayout(
      data: OnboardModel.first,
      actions: [
        CustomButton(
          text: AppTexts.getStarted,
          onPressed: () => Go.to(context, Pager.onboardAuth),
        ),
      ],
    );
  }
}
