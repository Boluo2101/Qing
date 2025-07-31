import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  Tabs({super.key, required this.currentIndex, required this.onTap});

  final List tabsList = [
    {'key': '1', 'label': 'TAB 1'},
    {'key': '2', 'label': 'TAB 2'},
    {'key': '3', 'label': 'TAB 3'},
    {'key': '4', 'label': 'TAB 4'},
    {'key': '5', 'label': 'TAB 5'},
    {'key': '6', 'label': 'TAB 6'},
    {'key': '7', 'label': 'TAB 7'},
    {'key': '8', 'label': 'TAB 8'},
    {'key': '9', 'label': 'TAB 9'},
    {'key': '10', 'label': 'TAB 10'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 可滚动的标签栏
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[200]!, // 底部灰色分隔线
                width: 1,
              ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabsList.asMap().entries.map((entry) {
                final int idx = entry.key;
                final item = entry.value;
                final isSelected = currentIndex == idx;

                return InkWell(
                  onTap: () => onTap(idx),
                  // 增加点击区域
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected
                              ? Color(0xFF144ee6)
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected
                                ? Color(0xFF144ee6)
                                : Colors.grey[900],
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
