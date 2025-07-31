// UI
import 'package:flutter/material.dart';

// Components
import '../../components/header_bar.dart';
import '../../components/tabs.dart';

// Routers
import 'package:go_router/go_router.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  int tabIndex = 6; // 当前选中的标签索引

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          borderShow: false,
          title: '全部课程',
          leftActions: [
            IconButton(
              icon: const Icon(Icons.chevron_left_sharp),
              onPressed: () {
                // 返回上一页 - 类似于Vue的this.$router.back()
                print('左侧菜单按钮被点击');
                // context.go('/home'); // 跳转到首页，类似于Vue的this.$router.push
                context.pop(); // 返回上一页，类似于Vue的this.$router.back()
              },
            ),
          ],
          rightActions: [],
        ),
      ),
      body: Container(
        child: Tabs(
          currentIndex: tabIndex,
          onTap: (index) {
            // 处理底部导航栏的点击事件
            print('当前选中的索引: $index');
            setState(() {
              tabIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 30),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Color(0xFF144ee6),
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            print('开始学习');
            // 在这里添加开始学习的处理逻辑
            GoRouter.of(context).push('/course/1');
          },
          child: Text('添加词书', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
