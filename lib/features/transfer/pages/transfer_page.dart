import 'package:flutter/material.dart';

import '../../../common/widgets/custom_app_bar.dart';

/// Placeholder — will be replaced with the real design.
class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Transfer'),
      body: Center(
        child: Text(
          'Transfer',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
