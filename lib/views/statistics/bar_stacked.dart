import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class StackedBarChart extends StatelessWidget {
  final double height;
  final color = Color(0xFF144ee6);

  StackedBarChart({super.key, this.height = 300});

  final List<int> hours = List.generate(24, (i) => 0 + i);
  final List<double> values = [
    100,
    120,
    100,
    50,
    30,
    64,
    64,
    10,
    21,
    32,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    70,
    80,
    50,
    60,
    95,
    100,
    110,
  ];
  final List<int> years = List.generate(5, (i) => 2025 - i);
  double get maxY => values.reduce((a, b) => math.max(a, b));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // label items
          Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Wrap(
              direction: Axis.horizontal,
              // 主轴对齐：靠左排列
              alignment: WrapAlignment.start,
              // 交叉轴对齐：改为起始位置对齐（顶部对齐）
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 12, // 水平间距
              children: years
                  .map(
                    (year) => Row(
                      mainAxisSize: MainAxisSize.min, // 关键：让Row只占用必要空间
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: color.withOpacity(1 - (2025 - year) * 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(year.toString()),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: (maxY * 5) + 10,

                // labels
                barTouchData: BarTouchData(enabled: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        int idx = value.toInt();
                        if (idx < 0 || idx >= hours.length) return Container();
                        return Text(
                          hours[idx].toString(),
                          style: TextStyle(fontSize: 10),
                        );
                      },
                      interval: 1,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(hours.length, (i) {
                  return BarChartGroupData(
                    x: i,
                    groupVertically: true,
                    barRods: [
                      BarChartRodData(
                        toY: values[i],
                        color: color,
                        width: 12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      BarChartRodData(
                        fromY: values[i] + 2,
                        toY: values[i] * 2,
                        color: color.withOpacity(0.7),
                        width: 12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      BarChartRodData(
                        fromY: values[i] * 2 + 2,
                        toY: values[i] * 3,
                        color: color.withOpacity(0.6),
                        width: 12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      BarChartRodData(
                        fromY: values[i] * 3 + 2,
                        toY: values[i] * 4,
                        color: color.withOpacity(0.5),
                        width: 12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      BarChartRodData(
                        fromY: values[i] * 4 + 2,
                        toY: values[i] * 5,
                        color: color.withOpacity(0.4),
                        width: 12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
