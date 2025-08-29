// UI
import 'package:flutter/material.dart';

// Tools
import 'package:go_router/go_router.dart';

// Components
import '../../components/header_bar.dart';
import '../../components/tabs.dart';

String getMonthEnStrByInt(int month) {
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return monthNames[month - 1];
}

String getWeekdayZnStrByInt(int weekday) {
  const weekdayNames = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'];
  return weekdayNames[weekday - 1];
}

int getWeekdayIntByYearMonthDay(int year, int month, int day) {
  final DateTime date = DateTime(year, month, day);
  return date.weekday;
}

class StatisticsPage extends StatefulWidget {
  StatisticsPage({super.key});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final List<Map<String, dynamic>> users = [
    {
      'totalNum': 410,
      'now': '《银河系搭车客指南》',
      'totalHour': 999,
      'text': '你与书籍的交响曲，正在唤醒世界的和声。',
      'day': 28,
      'month': 2,
      'year': 2025,
    },
    {
      'totalNum': 410,
      'now': '《银河系搭车客指南》',
      'totalHour': 999,
      'text': '对一本书来说，「读完」很难，但你仍穿过阅读之路的雾霭荆棘，到达了新的彼岸。',
      'day': 27,
      'month': 2,
      'year': 2025,
    },
    {
      'totalNum': 410,
      'now': '《银河系搭车客指南》',
      'totalHour': 999,
      'text': '你与书籍的交响曲，正在唤醒世界的和声。',
      'day': 26,
      'month': 2,
      'year': 2025,
    },
    {
      'totalNum': 410,
      'now': '《银河系搭车客指南》',
      'totalHour': 999,
      'text': '你与书籍的交响曲，正在唤醒世界的和声。',
      'day': 28,
      'month': 1,
      'year': 2025,
    },
    {
      'totalNum': 410,
      'now': '《银河系搭车客指南》',
      'totalHour': 999,
      'text': '你与书籍的交响曲，正在唤醒世界的和声。',
      'day': 22,
      'month': 12,
      'year': 2024,
    },
    {
      'totalNum': 410,
      'now': '《银河系搭车客指南》',
      'totalHour': 999,
      'text': '你与书籍的交响曲，正在唤醒世界的和声。',
      'day': 20,
      'month': 11,
      'year': 2024,
    },
    {
      'totalNum': 410,
      'now': '《银河系搭车客指南》',
      'totalHour': 999,
      'text': '你与书籍的交响曲，正在唤醒世界的和声。',
      'day': 7,
      'month': 5,
      'year': 2024,
    },
  ];

  final color = Color(0xFF144ee6);

  int tabIndex = 1;

  Widget _buildHistoryList() {
    return ListView.builder(
      itemCount: users.length, // +1 for the image
      padding: const EdgeInsets.only(top: 16.0),
      itemBuilder: (context, index) {
        final item = users[index];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              // 左侧线
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 6,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              // 右侧内容区
              Container(
                margin: const EdgeInsets.only(left: 6),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item['day']}',
                        style: TextStyle(
                          fontSize: 60.0,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${getMonthEnStrByInt(item['month'])}',
                        style: TextStyle(
                          fontSize: 26.0,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        '${item['month']}月${item['day']}日 · ${getWeekdayZnStrByInt(getWeekdayIntByYearMonthDay(item['year'], item['month'], item['day']))}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40.0),

                      Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(text: "那时，你正在阅读"),
                            TextSpan(
                              text: "${item['now']}",
                              style: TextStyle(
                                color: color,
                                decoration: TextDecoration.underline,
                                decorationColor: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: "。"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8.0),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(fontSize: 16.0),
                          children: [
                            TextSpan(text: "累计阅读时长 "),
                            TextSpan(
                              text: "${item['totalHour']}",
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: " 小时。"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        item['text'],
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCharts() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            '学习时长统计',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          // 在这里添加图表组件
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (tabIndex) {
      case 0:
        return _buildHistoryList();
      case 1:
        return _buildCharts();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          borderShow: false,
          title: '我的学习',
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
      body: Column(
        children: [
          Tabs(
            currentIndex: tabIndex,
            tabsList: [
              {'key': 0, 'label': '学习记录'},
              {'key': 1, 'label': '总统计'},
              {'key': 2, 'label': '年'},
              {'key': 3, 'label': '月'},
              {'key': 4, 'label': '周'},
              {'key': 5, 'label': '天'},
            ],
            onTap: (index) {
              // 处理底部导航栏的点击事件
              print('当前选中的索引: $index');
              setState(() {
                tabIndex = index;
              });
            },
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }
}
