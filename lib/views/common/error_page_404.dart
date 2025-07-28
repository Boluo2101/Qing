// 404页面 - 处理未找到的路由
// Flutter的材料设计组件库
import 'package:flutter/material.dart';
// 自定义头部导航栏组件
import '../../components/header_bar.dart';
// GoRouter路由库，用于页面导航
import 'package:go_router/go_router.dart';

// 404页面组件 - 继承自StatelessWidget
// StatelessWidget是Flutter中的无状态组件，类似于Vue的函数式组件
// 适用于不需要管理内部状态的组件
class NotFoundPage extends StatelessWidget {
  // 构造函数 - 使用const优化性能
  const NotFoundPage({super.key});

  // build方法 - 构建UI
  // 类似于Vue的render函数，返回Widget树
  @override
  Widget build(BuildContext context) {
    // 返回Scaffold页面框架
    return Scaffold(
      // appBar - 使用PreferredSize包装自定义AppBar
      appBar: PreferredSize(
        // Size.fromHeight - 根据高度创建尺寸对象
        preferredSize: Size.fromHeight(50),
        child: HeaderBar(
          title: '404 - 页面未找到', // 页面标题
          leftActions: [
            // IconButton - 图标按钮，用于返回导航
            IconButton(
              icon: const Icon(Icons.chevron_left_outlined), // 左箭头图标
              iconSize: 22.0, // 图标大小
              onPressed: () {
                // 返回上一页 - 类似于Vue的this.$router.back()
                print('左侧菜单按钮被点击');
                // context.go('/home'); // 跳转到首页，类似于Vue的this.$router.push
                context.pop(); // 返回上一页，类似于Vue的this.$router.back()
              },
            ),
          ],
          rightActions: [], // 空的右侧操作列表
        ),
      ),
      body: const Center(child: Text('404 - 页面未找到')),
    );
  }
}
