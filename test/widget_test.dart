import 'package:flutter_test/flutter_test.dart';

import 'package:savin_bank_app/core/extensions/num_extensions.dart';
import 'package:savin_bank_app/main.dart';

void main() {
  testWidgets('App boots on the splash screen', (tester) async {
    await tester.pumpWidget(const SavinBankApp());
    expect(find.text('Savin Bank'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Get Started'), findsOneWidget);
  });

  test('toCurrency formats with thousands separators', () {
    expect(24850.75.toCurrency(), '\$24,850.75');
    expect((-32.9).toSignedCurrency(), '-\$32.90');
  });
}
