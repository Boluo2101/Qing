// 一个自定义的Flutter头部，左侧三个图标带文字，右侧两个图标

// UI
import 'package:flutter/material.dart';

class WordsHeader extends StatelessWidget {
  const WordsHeader(this.scrollOffset, {super.key});

  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    // 根据滚动偏移量计算文字颜色，从白色渐变到黑色
    final double normalizedOffset = (scrollOffset / 50).clamp(0.0, 1.0);
    final Color textColor = Color.lerp(
      Colors.white,
      Colors.black.withOpacity(0.8),
      normalizedOffset,
    )!;

    final Color iconWithTextBgColor = Color.lerp(
      Colors.white.withOpacity(0.2),
      Colors.grey.withOpacity(0.1),
      normalizedOffset,
    )!;

    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top, // 动态获取状态栏高度
          color: Colors.transparent, // 设置背景颜色
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10), // 内边距
          height: 50, // 固定高度
          decoration: BoxDecoration(color: Colors.transparent), // 设置背景颜色
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 圆角背景色，下面是icon和文字
              GestureDetector(
                onTap: () {
                  print('能量值被点击了');
                  // 在这里添加能量值点击的处理逻辑
                },
                child: Container(
                  height: 35,
                  margin: const EdgeInsets.fromLTRB(6, 0, 10, 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    // 白色透明20
                    color: iconWithTextBgColor,
                    borderRadius: BorderRadius.circular(25), // 圆角
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.electric_bolt_sharp,
                        color: Colors.orangeAccent,
                      ),
                      SizedBox(width: 5), // 间距
                      Text('100', style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  print('排名被点击了');
                  // 在这里添加排名点击的处理逻辑
                },
                child: Container(
                  height: 35,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: iconWithTextBgColor,
                    borderRadius: BorderRadius.circular(25), // 圆角
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.perm_contact_calendar_sharp,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 5), // 间距
                      Text('排名', style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  print('任务被点击了');
                  // 在这里添加任务点击的处理逻辑
                },
                child: Container(
                  height: 35,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: iconWithTextBgColor,
                    borderRadius: BorderRadius.circular(25), // 圆角
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.list_alt_sharp, color: Colors.orangeAccent),
                      SizedBox(width: 5), // 间距
                      Text('任务', style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
              ),

              // Flex 1
              const Expanded(child: SizedBox()), // 占位，确保左侧图标和文字居中
              // 右侧两个图标
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.mail_outline_sharp, color: textColor),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
