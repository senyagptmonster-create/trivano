import 'package:flutter_test/flutter_test.dart';
import 'package:trivano/presentation/trivano_app.dart';

void main() {
  testWidgets('TrivanoApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TrivanoApp());
    await tester.pump();
    expect(find.text('Gear Inventory'), findsWidgets);
  });
}
