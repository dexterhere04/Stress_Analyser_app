import 'package:flutter_test/flutter_test.dart';
import 'package:destresser/main.dart';

void main() {
  testWidgets('DeStresser app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DeStresserApp());
    await tester.pumpAndSettle();

    expect(find.text('DeStresser'), findsOneWidget);
  });
}
