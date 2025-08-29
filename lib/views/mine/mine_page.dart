// UI
import 'package:flutter/material.dart';

// Tools
import '../../tools/custom_colors.dart';

// Routers
import 'package:go_router/go_router.dart';

// Components
import '../../components/header_bar.dart';

class MinePage extends StatefulWidget {
  MinePage({super.key});

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static final iconColor = CustomColors.getColorByStr('blue');

  final List<Map<String, dynamic>> items = [
    {'type': 'line'},
    {
      'title': '累计已学 666 天',
      'fontWeight': FontWeight.bold,
      'icon': Icon(Icons.bar_chart, color: Colors.lightBlueAccent),
      'path': '/ranking',
    },
    {'type': 'line'},
    {
      'title': '233 个铜板',
      'fontWeight': FontWeight.bold,
      'icon': Icon(Icons.monetization_on, color: Colors.orangeAccent),
    },
    {'type': 'line'},
    {
      'title': '我的日历',
      'icon': Icon(Icons.calendar_month_outlined, color: iconColor),
    },
    {'title': '我的学习', 'icon': Icon(Icons.book, color: iconColor)},
    {
      'title': '我的能量',
      'icon': Icon(Icons.energy_savings_leaf_outlined, color: iconColor),
    },
    {'type': 'line'},
    {
      'title': '我的收藏',
      'icon': Icon(Icons.favorite_border_sharp, color: iconColor),
    },
    {'title': '我的图书', 'icon': Icon(Icons.library_books, color: iconColor)},
    {'type': 'line'},
    {'title': '官方商城', 'icon': Icon(Icons.store, color: iconColor)},
    {
      'title': '帮助与反馈',
      'icon': Icon(Icons.help_outline_sharp, color: iconColor),
      'path': '/feedback',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 使用灰色背景色
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          bgColor: Colors.grey[100],
          borderShow: false,
          title: '',
          leftActions: [],
          rightActions: [
            IconButton(
              icon: const Icon(Icons.qr_code_scanner_sharp),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16.0, 6, 16, 16),
          child: Column(
            children: [
              Row(
                children: [
                  // Avatar , Username
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                      'https://testingbot.com/free-online-tools/random-avatar/200',
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '菠萝菠萝不吃鸡',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.0),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                  5,
                                  1,
                                  5,
                                  1,
                                ), // 可选，添加内边距让文字不贴边
                                decoration: BoxDecoration(
                                  color: Colors.grey[300], // 背景色
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ), // 圆角半径
                                ),
                                child: Text(
                                  'UID: 20250808',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          color: Color(0xFFcccccc),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // List
              ...items.map((item) {
                // line
                if (item['type'] == 'line') {
                  return SizedBox(height: 20);
                }

                return ListTile(
                  tileColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
                  leading: item['icon'],
                  title: Text(
                    item['title'],
                    style: TextStyle(
                      fontWeight: item['fontWeight'] ?? FontWeight.normal,
                      fontSize: 16.0,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Color(0xFFcccccc),
                    size: 20,
                  ),
                  onTap: () {
                    // Handle tap event here
                    print('Tapped on ${item['title']}');

                    final path = item['path'];
                    if (path == null) return;

                    context.push(path);
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
