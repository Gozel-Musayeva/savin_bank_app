import 'package:flutter/material.dart';

import '../../../common/widgets/custom_app_bar.dart';

/// Placeholder — will be replaced with the real design.
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Cards'),
      body: Center(
        child: Text(
          'My Cards',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
