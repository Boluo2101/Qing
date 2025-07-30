import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 底部导航栏组件 - 继承自ConsumerWidget支持状态管理
// 类似于Vue中的底部导航组件，但Flutter更加声明式
class BottomTabs extends ConsumerWidget {
  // 组件属性 - 使用final确保不可变性，Flutter推荐的最佳实践
  final int currentIndex; // 当前选中的tab索引，类似于Vue的v-model
  final Function(int) onTap; // 点击回调函数，类似于Vue的@click事件

  // 构造函数 - required确保必传参数，类似于Vue的required props
  const BottomTabs({
    super.key, // Widget的唯一标识符，用于性能优化
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 返回BottomNavigationBar - Flutter的底部导航栏组件
    // 类似于Vue的底部导航，但Flutter提供了更丰富的Material Design样式
    // BottomNavigationBar常用属性：
    // - type: 导航栏类型，fixed(固定)/shifting(移动)
    // - backgroundColor: 背景色，支持主题切换
    // - selectedItemColor: 选中项颜色，Material Design规范
    // - unselectedItemColor: 未选中项颜色
    // - currentIndex: 当前选中索引，类似于Vue的active-index
    // - onTap: 点击回调，类似于Vue的@tab-click
    // - items: 导航项列表，必需属性
    // - showSelectedLabels: 是否显示选中标签，默认true
    // - showUnselectedLabels: 是否显示未选中标签，默认true
    // - selectedFontSize: 选中标签字体大小，默认14
    // - unselectedFontSize: 未选中标签字体大小，默认12
    // - iconSize: 图标大小，默认24
    // - elevation: 阴影高度，Material Design的层级概念
    return BottomNavigationBar(
      // Styles - 样式配置
      backgroundColor: Colors.white, // 使用自定义主题色
      type: BottomNavigationBarType.fixed, // 固定类型的底部导航栏
      showUnselectedLabels: true, // 显示未选中的标签
      showSelectedLabels: true, // 显示选中的标签
      selectedFontSize: 11, // 选中标签的字体大小
      currentIndex: currentIndex, // 当前选中的索引
      unselectedFontSize: 11, // 未选中标签的字体大小
      iconSize: 24, // 图标大小
      selectedItemColor: Colors.black, // 使用主题主色
      unselectedItemColor: Colors.grey, // 使用主题色系
      onTap: onTap, // 点击回调
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_sharp), // 使用Material Icons
          label: '字词', // 标签文本
        ),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '学习'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: '一起玩'),
        BottomNavigationBarItem(icon: Icon(Icons.money_outlined), label: '商城'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '我'),
      ],
    );
  }
}
