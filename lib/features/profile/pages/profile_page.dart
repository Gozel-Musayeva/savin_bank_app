import 'package:flutter/material.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../widgets/theme_switch_tile.dart';

/// Placeholder — will be replaced with the real design.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
      body: ListView(children: const [ThemeSwitchTile()]),
    );
  }
}
