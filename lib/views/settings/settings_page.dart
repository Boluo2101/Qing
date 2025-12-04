// UI
import 'package:flutter/material.dart';

// Tools
import 'package:go_router/go_router.dart';

// Components
import '../../components/header_bar.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final List<Map<String, String>> menus = [
    {'title': '', 'type': 'hr'},
    {'title': '账号管理'},
    {'title': '', 'type': 'hr'},
    {'title': '深色主题'},
    {'title': '', 'type': 'hr'},
    {'title': '缓存管理'},
    {'title': '个人信息收集清单'},
    {'title': '第三方合作清单'},
    {'title': '关于我们'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 使用灰色背景色
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          borderShow: false,
          title: '设置',
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
        itemCount: menus.length, // +1 for the image
        itemBuilder: (context, index) {
          final menuIndex = index;
          final type = menus[menuIndex]['type'];
          if (type == 'hr') {
            // 分割线
            return Container(height: 20, color: Colors.grey[100]);
          }

          // 其他菜单项
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color.fromRGBO(245, 245, 245, 1)),
              ),
            ),
            child: ListTile(
              title: Text(menus[menuIndex]['title']!),
              onTap: () {
                // 点击问题时的处理逻辑
                print('点击了问题：${menus[menuIndex]['title']}');
              },
            ),
          );
        },
      ),
    );
  }
}
