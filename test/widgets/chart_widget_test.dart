import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/widgets/chart_widget.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  group('ChartWidget Tests', () {
    testWidgets('should render correctly with data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ChartWidget(income: 5000, expense: 2000)),
        ),
      );

      expect(find.byType(PieChart), findsOneWidget);
      expect(find.text('Balance'), findsOneWidget);

      // (5000 / 7000) * 100 = 71.4%
      // (2000 / 7000) * 100 = 28.6%
      // Diff = 42.8% -> 43%
      expect(find.text('43%'), findsOneWidget);
    });

    testWidgets('should handle zero values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ChartWidget(income: 0, expense: 0))),
      );

      expect(find.byType(PieChart), findsOneWidget);
      expect(find.text('0%'), findsOneWidget);
    });

    testWidgets('should calculate negative balance percentage correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ChartWidget(income: 1000, expense: 3000)),
        ),
      );

      // (1000 / 4000) * 100 = 25%
      // (3000 / 4000) * 100 = 75%
      // Diff = -50% -> abs -> 50%
      expect(find.text('50%'), findsOneWidget);
    });
  });
}
