import 'package:flutter/material.dart';

import '../../../common/widgets/custom_app_bar.dart';

/// Placeholder — will be replaced with the real design.
class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Statistics'),
      body: Center(
        child: Text(
          'Statistics',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
