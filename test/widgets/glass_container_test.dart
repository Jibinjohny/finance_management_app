import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/widgets/glass_container.dart';

void main() {
  testWidgets('GlassContainer renders with child', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: GlassContainer(child: Text('Glass Content'))),
      ),
    );

    expect(find.text('Glass Content'), findsOneWidget);
    expect(find.byType(Container), findsWidgets);
  });
}
