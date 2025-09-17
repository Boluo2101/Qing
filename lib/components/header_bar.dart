// 一个自定义实现的头部导航栏组件，不用官方AppBar组件实现
// 类似于Vue中的自定义Header组件，提供更多的自定义能力
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 自定义头部导航栏组件 - 继承自ConsumerWidget支持状态管理
// 相比官方AppBar，这个组件提供了更多的自定义空间
// 类似于Vue中完全自定义的Header组件
class HeaderBar extends ConsumerWidget {
  // 组件属性 - 使用final确保不可变性
  final String title; // 标题文本，类似于Vue的title prop
  final List<Widget> leftActions; // 左侧操作按钮列表，类似于Vue的左侧插槽
  final List<Widget> rightActions; // 右侧操作按钮列表，类似于Vue的右侧插槽
  final Color? bgColor; // 背景色，可选属性，类似于Vue的backgroundColor prop
  final bool? borderShow;
  final double? leftWidth;
  final double? rightWidth;

  // 构造函数 - required确保必传参数
  const HeaderBar({
    super.key, // Widget的唯一标识符
    this.bgColor, // 可选的背景色
    required this.title, // 必传的标题
    required this.leftActions, // 必传的左侧操作列表
    required this.rightActions, // 必传的右侧操作列表
    this.borderShow = true, // 是否显示底部分割线，默认true
    this.leftWidth = 100, // 左侧区域宽度，默认100
    this.rightWidth = 100, // 右侧区域宽度，默认100
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 获取主题信息

    // 返回Column - 垂直布局容器
    // Column常用属性：
    // - children: 子组件列表，必需属性
    // - mainAxisAlignment: 主轴对齐方式(垂直方向)
    // - crossAxisAlignment: 交叉轴对齐方式(水平方向)
    // - mainAxisSize: 主轴尺寸(min/max)
    return Column(
      children: [
        // 状态栏高度占位 - 适配iPhone等设备的状态栏
        // 类似于Vue中的safe-area处理，确保内容不被状态栏遮挡
        // Container常用属性：
        // - height: 高度，可以是固定值或动态计算
        // - width: 宽度
        // - color: 背景色
        // - decoration: 装饰器，用于复杂样式(边框、阴影等)
        // - padding: 内边距，类似于CSS的padding
        // - margin: 外边距，类似于CSS的margin
        // - alignment: 内容对齐方式
        // - child: 子组件，只能包含一个子组件
        Container(
          height: MediaQuery.of(context).padding.top, // 动态获取状态栏高度
          color: bgColor ?? Colors.white, // 设置背景颜色
        ),

        // 导航栏主体
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ), // 内边距
          height: 50, // 固定高度
          // BoxDecoration - 容器装饰器，用于复杂样式
          // 类似于Vue中的样式对象，但Flutter更加类型安全
          // BoxDecoration常用属性：
          // - color: 背景色
          // - gradient: 渐变背景
          // - border: 边框，可以设置四边或单边
          // - borderRadius: 圆角
          // - boxShadow: 阴影效果
          // - image: 背景图片
          decoration: BoxDecoration(
            color: bgColor ?? Colors.white, // 背景颜色
            border: borderShow == true
                ? Border(
                    bottom: BorderSide(
                      color: Colors.grey, // 分割线颜色
                      width: 0.5, // 分割线宽度
                    ), // 底部边框
                  )
                : null,
          ),

          // Row - 水平布局容器
          // Row常用属性：
          // - children: 子组件列表，必需属性
          // - mainAxisAlignment: 主轴对齐方式(水平方向)
          // - crossAxisAlignment: 交叉轴对齐方式(垂直方向)
          // - mainAxisSize: 主轴尺寸(min/max)
          // - textDirection: 文本方向(ltr/rtl)
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 两端对齐
            crossAxisAlignment: CrossAxisAlignment.center, // 垂直居中
            children: [
              // 左侧区域 - 固定宽度确保标题居中
              // SizedBox常用属性：
              // - width: 宽度，可以是固定值或infinity
              // - height: 高度
              // - child: 子组件
              SizedBox(
                width: leftWidth ?? 100, // 固定宽度
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // 左对齐
                  children: leftActions, // 左侧操作按钮列表
                ),
              ),

              // 中间标题区域 - 使用Expanded确保始终居中
              // Expanded常用属性：
              // - flex: 弹性系数，类似于CSS的flex-grow
              // - child: 子组件，必需属性
              if (title.isNotEmpty)
                Expanded(
                  flex: 1, // 弹性系数
                  child: Text(
                    title, // 标题文本
                    // TextStyle - 文本样式配置
                    // 类似于Vue中的文本样式对象
                    // TextStyle常用属性：
                    // - fontSize: 字体大小
                    // - fontWeight: 字体粗细(normal/bold等)
                    // - color: 文字颜色
                    // - fontFamily: 字体族
                    // - letterSpacing: 字母间距
                    // - height: 行高
                    // - decoration: 文本装饰(underline等)
                    style: TextStyle(
                      fontSize: 16, // 字体大小
                      fontWeight: FontWeight.w600, // 字体粗细
                      color: Colors.black, // 文字颜色
                    ),
                    textAlign: TextAlign.center, // 文本对齐方式
                  ),
                ),

              // 右侧区域 - 固定宽度确保标题居中
              SizedBox(
                width: rightWidth ?? 100, // 固定宽度
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end, // 右对齐
                  children: rightActions, // 右侧操作按钮列表
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
