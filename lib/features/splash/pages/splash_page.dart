import 'package:flutter/material.dart';

import '../../../common/widgets/custom_logo.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _waitThenGo();
  }

  Future<void> _waitThenGo() async {
    await Future.delayed(AppDurations.s2);
    if (!mounted) return;
    Go.replace(context, Pager.onboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: const Center(child: CustomLogo.large()),
    );
  }
}
