// UI
import 'package:flutter/material.dart';

// Tools
import 'package:go_router/go_router.dart';

// Components
import '../../components/header_bar.dart';

class RankingPage extends StatelessWidget {
  RankingPage({super.key});

  final Map<String, dynamic> user = {
    'username': '菠萝🍍',
    'timeStr': '7时13分',
    'star': 11,
    'avatar': 'https://testingbot.com/free-online-tools/random-avatar/100',
    'isVIP': true,
  };

  final List<Map<String, dynamic>> users = [
    {
      'username': '菠萝🍍',
      'timeStr': '7时13分',
      'star': 11,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/200',
      'isVIP': true,
    },
    {
      'username': '小猴子🦁',
      'timeStr': '7时13分',
      'star': 10,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/300',
      'isVIP': true,
    },
    {
      'username': '花花🌸',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/302',
      'isVIP': false,
    },
    {
      'username': '小猴子',
      'timeStr': '7时13分',
      'star': 10,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/201',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/301',
      'isVIP': true,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/401',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/501',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/601',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/70',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/80',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/90',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/100',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/110',
      'isVIP': false,
    },
    {
      'username': '花花',
      'timeStr': '7时13分',
      'star': 9,
      'avatar': 'https://testingbot.com/free-online-tools/random-avatar/120',
      'isVIP': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          borderShow: false,
          title: '学习排行榜',
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
      body: ListView.builder(
        itemCount: users.length + 1, // +1 for the image
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['username'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user['timeStr'],
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // flex 1
                  const Spacer(),
                  // btn
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      10,
                      6,
                      10,
                      6,
                    ), // 可选，添加内边距让文字不贴边
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // 背景色
                      borderRadius: BorderRadius.circular(20), // 圆角半径
                    ),
                    child: Text(
                      ' 我的学习统计 ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF144ee6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // 其他项目是问题列表
            final userIndex = index - 1;
            final userItem = users[userIndex];
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.1),
                ),
              ),
              child: ListTile(
                title: Text(
                  userItem['username']!,
                  style: TextStyle(
                    color: userItem['isVIP'] ? Color(0xFF144ee6) : Colors.black,
                    fontWeight: userItem['isVIP']
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                leading: Row(
                  mainAxisSize: MainAxisSize.min, // 确保 Row 只占用必要空间
                  children: [
                    // 文字
                    Text(
                      (userIndex + 1).toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: userItem['isVIP']
                            ? Color(0xFF144ee6)
                            : Colors.grey, // 根据是否是VIP设置颜色
                      ),
                    ),
                    // 文字与头像间距
                    const SizedBox(width: 16),
                    // 头像
                    CircleAvatar(
                      backgroundImage: NetworkImage(userItem['avatar']!),
                    ),
                  ],
                ),
                // right text with icon
                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // 确保 Row 只占用必要空间
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      userItem['timeStr']!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 8), // 文本和图标之间的间距
                    Icon(
                      Icons.favorite_border_rounded,
                      color: Colors.grey,
                      size: 20,
                    ),
                    Text(
                      '13',
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ],
                ),
                onTap: () {
                  // 点击问题时的处理逻辑
                  print('点击了问题：${userItem['title']}');
                },
              ),
            );
          }
        },
      ),
    );
  }
}
