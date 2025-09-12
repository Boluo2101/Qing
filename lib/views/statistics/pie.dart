import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class PieChartWidget extends StatefulWidget {
  final List<PieData> data;
  final double size;

  const PieChartWidget({super.key, required this.data, this.size = 200});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    final centerSpaceRadius = 40.0;
    widget.data.fold<double>(0, (sum, d) => sum + d.value);

    return SizedBox(
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: PieChart(
              PieChartData(
                sections: _showingSections(),
                sectionsSpace: 2,
                centerSpaceRadius: centerSpaceRadius,
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          // 标签列表
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(widget.data.length, (i) {
              final item = widget.data[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item.label} (${item.value.toInt()})',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: item.color,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(widget.data.length, (i) {
      final radius = 50.0;
      final item = widget.data[i];
      return PieChartSectionData(
        color: item.color,
        value: item.value,
        title: '', // 饼图不显示文字
        radius: radius,
        showTitle: false,
      );
    });
  }
}

class PieData {
  final String label;
  final double value;
  final Color color;

  PieData({required this.label, required this.value, required this.color});
}

// mock 数据示例
final List<PieData> mockPieData = [
  PieData(label: '神作', value: 30, color: Colors.red[500]!),
  PieData(label: '好评如潮', value: 20, color: Colors.deepOrange),
  PieData(label: '褒贬不一', value: 20, color: Color.fromARGB(255, 20, 80, 230)),
  PieData(label: '值得一读', value: 15, color: Color.fromARGB(255, 20, 80, 230)),
  PieData(label: '脍炙人口', value: 10, color: Color.fromARGB(255, 20, 80, 230)),
  PieData(label: '不值一读', value: 5, color: Colors.grey[500]!),
];

// 使用示例 Widget
class PieChartDemo extends StatelessWidget {
  const PieChartDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: PieChartWidget(data: mockPieData),
    );
  }
}
