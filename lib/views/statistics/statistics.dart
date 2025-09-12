// UI
import 'package:flutter/material.dart';

// Tools
import 'package:go_router/go_router.dart';
import 'dart:math';

// Components
import '../../components/header_bar.dart';
import '../../components/tabs.dart';
import './bar.dart';
import './radar.dart';
import './pie.dart';
import './words.dart';
import './bar_stacked.dart';

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

int getDaysNumberByYearMonth(int year, int month) {
  // 获取下个月的第一天
  final nextMonth = (month == 12) ? 1 : month + 1;
  final nextMonthYear = (month == 12) ? year + 1 : year;

  // 下个月的第一天减去一天就是当前月的最后一天
  final lastDayOfMonth = DateTime(
    nextMonthYear,
    nextMonth,
    1,
  ).subtract(Duration(days: 1));
  return lastDayOfMonth.day;
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
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

  Widget _buildCardWithTitle(String title, Widget child, String infoText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.fromLTRB(16.0, 16, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: TextStyle(fontSize: 14.0)),

                Expanded(
                  child: Text(
                    infoText,
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildCharts() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          _buildCardWithTitle('阅读时长分布', TotalBarChart(), ''),
          _buildCardWithTitle('偏好阅读科幻小说', CategoryRadarChart(), ''),
          _buildCardWithTitle('阅读时间段分布', StackedBarChart(), '偏好深夜阅读'),
          _buildCardWithTitle('书籍分布', PieChartDemo(), '累计阅读220本'),
          _buildCardWithTitle('偏好作者', WordsCloud(), '# 安利我喜欢的作者'),
          _buildCardWithTitle('偏好版权方', WordsCloud(), ''),
        ],
      ),
    );
  }

  Widget _buildMonthCalendar(int month, bool isToMonth, bool isLargeMode) {
    final random = Random();
    const weekDays = ['一', '二', '三', '四', '五', '六', '日'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$month月',
          style: TextStyle(
            fontWeight: isToMonth ? FontWeight.bold : FontWeight.normal,
            color: isToMonth ? color : Colors.black,
            fontSize: isLargeMode ? 24.0 : 16.0,
          ),
        ),

        SizedBox(height: isLargeMode ? 0 : 8.0),
        Expanded(
          // 一个月中的天数，一天是一个block
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: isLargeMode ? 12.0 : 4.0,
              mainAxisSpacing: isLargeMode ? 12 : 4.0,
            ),
            itemCount: 35 + (isLargeMode ? 7 : 0), // 35个格子 + 7个星期标题
            itemBuilder: (context, dayIndex) {
              // 星期标题，仅当isLargeMode时
              if (isLargeMode && dayIndex < 7) {
                return Center(
                  child: Text(
                    weekDays[dayIndex],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                );
              }

              // 根据年和月，获取这个月的天数，以及1号是在周几
              final days = getDaysNumberByYearMonth(2025, month);
              final firstDayOfWeek = DateTime(2025, month, 1).weekday;

              // 计算1号之前有几个格子，兼容标题，仅当isLargeMode时
              final leadingEmptyDays = isLargeMode
                  ? firstDayOfWeek - 1 + 7
                  : firstDayOfWeek - 1;
              if (dayIndex < leadingEmptyDays ||
                  dayIndex >= days + leadingEmptyDays) {
                // 空白格子
                return Container();
              }

              final day = dayIndex - leadingEmptyDays + 1;

              // 随机决定是否有阅读记录
              // 分浅灰色 浅蓝色 深蓝色 3种
              // 完全随机
              final hasRecord = random.nextBool();
              final hasDeepRecord = random.nextDouble() < 0.5; // 50%的概率为true
              Color color;
              if (hasDeepRecord) {
                color = Color(0xFF144ee6); // 深蓝色
              } else if (hasRecord) {
                color = Color(0xFF85a5ff); // 浅蓝色
              } else {
                color = Colors.grey[300]!; // 浅灰色
              }

              // 计算月份天数是否未到来
              final now = DateTime.now();
              if (DateTime(2025, month, day).isAfter(now)) {
                color = Colors.grey[300]!;
              }

              return Container(
                decoration: BoxDecoration(
                  color: hasRecord ? color : Colors.grey[300],
                  borderRadius: BorderRadius.circular(isLargeMode ? 12 : 4.0),
                ),
                alignment: Alignment.center,
                child: isLargeMode
                    ? Text(
                        day.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildYearStatistics() {
    final int totalDays = 166;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '2025年 · 累计阅读 $totalDays 天',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            '累计阅读 458 小时 3 分钟 · 最近连续阅读15天',
            style: TextStyle(color: Colors.grey[600]),
          ),

          const SizedBox(height: 16.0),
          // 12 个月的日历
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 32.0,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final month = index + 1;
                final isToMonth = month == DateTime.now().month;
                return _buildMonthCalendar(month, isToMonth, false);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthCalendarPage() {
    final int toMonth = DateTime.now().month;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '2025年 $toMonth 月 · 累计阅读 15 天',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            '累计阅读 78 小时 3 分钟 · 最近连续阅读15天',
            style: TextStyle(color: Colors.grey[600]),
          ),

          const SizedBox(height: 16.0),

          // 月历
          Expanded(child: _buildMonthCalendar(toMonth, true, true)),
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
      case 2:
        return _buildYearStatistics();
      case 3:
        return _buildMonthCalendarPage();
      case 4:
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
