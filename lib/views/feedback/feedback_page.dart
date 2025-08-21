// UI
import 'package:flutter/material.dart';

// Tools
import 'package:go_router/go_router.dart';

// Components
import '../../components/header_bar.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({super.key});

  final List<Map<String, String>> questions = [
    {'title': '如何修改个人信息？'},
    {'title': '如何修改密码？'},
    {'title': '如何查看使用帮助？'},
    {'title': '如何反馈问题？'},
    {'title': '如何联系客服？'},
    {'title': '如何删除账号？'},
    {'title': '如何查看隐私政策？'},
    {'title': '如何查看使用条款？'},
    {'title': '如何退出登录？'},
    {'title': '如何清除缓存？'},
    {'title': '如何更新应用？'},
    {'title': '如何查看版本信息？'},
    {'title': '如何查看常见问题？'},
    {'title': '如何查看更新日志？'},
    {'title': '如何查看使用统计？'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          borderShow: false,
          title: '帮助与反馈',
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
        itemCount: questions.length + 1, // +1 for the image
        itemBuilder: (context, index) {
          if (index == 0) {
            // 第一个项目图片
            return Image.asset('assets/images/servers.gif');
          } else {
            // 其他项目是问题列表
            final questionIndex = index - 1;
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.1),
                ),
              ),
              child: ListTile(
                title: Text(questions[questionIndex]['title']!),
                onTap: () {
                  // 点击问题时的处理逻辑
                  print('点击了问题：${questions[questionIndex]['title']}');
                },
              ),
            );
          }
        },
      ),
    );
  }
}
