import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CategoryPieChart extends StatefulWidget {
  final Map<String, double> data;

  const CategoryPieChart({super.key, required this.data});

  @override
  State<CategoryPieChart> createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends State<CategoryPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return Center(
        child: Text(
          'No expenses to show',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    final List<Color> colors = [
      AppColors.expense,
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
      Colors.cyan,
    ];

    final entries = widget.data.entries.toList();
    // Sort by value descending
    entries.sort((a, b) => b.value.compareTo(a.value));

    return AspectRatio(
      aspectRatio: 1.8,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 0),
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!
                              .touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 4,
                    centerSpaceRadius: 30,
                    sections: List.generate(entries.length, (i) {
                      final isTouched = i == touchedIndex;
                      final fontSize = isTouched ? 16.0 : 12.0;
                      final radius = isTouched ? 60.0 : 50.0;
                      final entry = entries[i];
                      final color = colors[i % colors.length];

                      return PieChartSectionData(
                        color: color,
                        value: entry.value,
                        title:
                            '${((entry.value / _total) * 100).toStringAsFixed(0)}%',
                        radius: radius,
                        titleStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: entries.asMap().entries.map((mapEntry) {
                  final index = mapEntry.key;
                  final entry = mapEntry.value;
                  final color = colors[index % colors.length];
                  final isTouched = index == touchedIndex;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: isTouched ? 16 : 12,
                          height: isTouched ? 16 : 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: isTouched ? 16 : 14,
                              fontWeight: isTouched
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isTouched ? Colors.white : Colors.white70,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get _total => widget.data.values.fold(0, (sum, item) => sum + item);
}
