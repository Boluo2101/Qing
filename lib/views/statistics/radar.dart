import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryRadarChart extends StatelessWidget {
  final double height;
  final color = Color(0xFF144ee6);

  CategoryRadarChart({super.key, this.height = 300});

  final List<String> categories = [
    '科幻',
    '哲学',
    '历史',
    '科学技术',
    '影视原著',
    '经济理财',
    '文学',
    '期刊杂志',
  ];

  final List<double> values = [
    10, 8, 5, 7, 9, 4, 8, 6, // mock 数据
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
        child: RadarChart(
          RadarChartData(
            radarBorderData: BorderSide(color: color, width: 2),
            tickBorderData: BorderSide(color: Colors.grey[300]!, width: 1),
            dataSets: [
              RadarDataSet(
                fillColor: color.withOpacity(0.5),
                borderColor: color,
                entryRadius: 5,
                dataEntries: values.map((v) => RadarEntry(value: v)).toList(),
              ),
            ],
            radarBackgroundColor: Colors.grey[200],
            titleTextStyle: TextStyle(fontSize: 12, color: Colors.black),
            getTitle: (index, angle) {
              return RadarChartTitle(text: categories[index]);
            },
            radarShape: RadarShape.circle,
          ),
        ),
      ),
    );
  }
}
