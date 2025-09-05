import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TotalBarChart extends StatelessWidget {
  final double height;
  final color = Color(0xFF144ee6);

  TotalBarChart({super.key, this.height = 300});

  final List<int> years = List.generate(11, (i) => 2015 + i);
  final List<double> values = [
    12,
    19,
    15,
    22,
    18,
    25,
    30,
    28,
    35,
    40,
    38,
  ]; // mock 数据

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 45,
          barTouchData: BarTouchData(enabled: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int idx = value.toInt();
                  if (idx < 0 || idx >= years.length) return Container();
                  return Text(
                    years[idx].toString(),
                    style: TextStyle(fontSize: 10),
                  );
                },
                interval: 1,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(years.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: values[i],
                  color: color,
                  width: 18,
                  borderRadius: BorderRadius.circular(20),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
