import 'package:flutter/material.dart';

import '../../../common/widgets/custom_app_bar.dart';

/// Placeholder — will be replaced with the real design.
class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Transactions'),
      body: Center(
        child: Text(
          'Transactions',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
