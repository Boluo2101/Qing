// UI
import 'dart:ui';

import 'package:flutter/material.dart';

// Tools
import 'package:go_router/go_router.dart';

// Components
import '../../components/header_bar.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  final String yearMonth =
      '${DateTime.now().year} / ${DateTime.now().month}'; // 2025 / 12
  final today = DateTime.now(); // 11
  final String weekday = DateTime.now().weekday.toString();
  final imgUrl = 'assets/images/cars/sunset.png';

  final list = [
    {'title': '冬至', 'text': '冬月初二 | 周日', 'diffNow': 10, 'key': 1},
    {'title': '澳门回归纪念日', 'text': '冬月廿一 | 周三', 'diffNow': 29, 'key': 2},
    {'title': '香港回归纪念日', 'text': '冬月廿五 | 周日', 'diffNow': 33, 'key': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 使用灰色背景色
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          borderShow: false,
          title: '',
          leftActions: [
            IconButton(
              icon: const Icon(Icons.chevron_left_sharp),
              onPressed: () {
                // 返回上一页 - 类似于Vue的this.$router.back()
                print('左侧菜单按钮被点击');
                context.pop(); // 返回上一页，类似于Vue的this.$router.back()
              },
            ),
          ],
          rightActions: [],
        ),
      ),
      body: ListView(
        children: [
          // 图片区域
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: [
                  // 图片
                  Image.asset(
                    imgUrl,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 300, // 改为固定高度
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          yearMonth,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        SizedBox(height: 0),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${today.day}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 100,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // 图片底部文字
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      '文本区这是AI生成的图片',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 列表区
          ...list.map((item) {
            return Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ListTile(
                  title: Text(item['title'] as String),
                  subtitle: Text(item['text'] as String),
                  trailing: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${item['diffNow']}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 4),
                      Text('天'),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
