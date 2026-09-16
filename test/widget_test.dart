import 'package:flutter_test/flutter_test.dart';
import 'package:trivano/trivano_app.dart';

void main() {
  testWidgets('TrivanoApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const TrivanoApp());
    expect(find.text('TRIVANO PACK WEIGHT'), findsOneWidget);
    expect(find.text('Base Weight'), findsOneWidget);
  });
}
