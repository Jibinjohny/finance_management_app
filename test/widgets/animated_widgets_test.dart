import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/widgets/animated_widgets.dart';

void main() {
  group('AnimatedWidgets Tests', () {
    testWidgets('AnimatedButton renders and handles tap', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                tapped = true;
              },
              child: Text('Tap Me'),
            ),
          ),
        ),
      );

      expect(find.text('Tap Me'), findsOneWidget);

      await tester.tap(find.byType(AnimatedButton));
      await tester.pumpAndSettle();

      expect(tapped, true);
    });

    testWidgets('FadeInAnimation renders child', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FadeInAnimation(
              delay: Duration.zero,
              child: Text('Fading In'),
            ),
          ),
        ),
      );

      // Initially might be invisible or animating, but should exist in tree
      expect(find.text('Fading In'), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('Fading In'), findsOneWidget);
    });
  });
}
