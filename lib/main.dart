// File: lib/main.dart
import 'package:flutter/material.dart';

// Flutter的核心包，包含Flutter的基础功能
import 'package:flutter/services.dart';

// Flutter的基础包，包含kDebugMode等调试相关常量
import 'package:flutter/foundation.dart';

// LocalStorage - SharedPreferences工具类
// SharedPreferences是Flutter中用于存储简单数据的持久化存储
// 类似于Vue的localStorage，但Flutter提供了更强大的类型支持
import 'tools/shared_preferences_util.dart';

// Store - 状态管理库
// Riverpod是Flutter官方推荐的状态管理方案，类似于Vue的Vuex/Pinia
// Flutter推崇"状态提升"的思想，通过Provider向下传递状态
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 引入 GoRouter 包 - 路由管理
// GoRouter是Flutter官方推荐的路由方案，类似于Vue Router
// Flutter的路由是基于"导航栈"的概念，而不是Vue的hash/history模式
import 'package:go_router/go_router.dart';

// Footer Tabs 组件
// Flutter中所有UI都是Widget，这是Flutter的核心思想
// 类似于Vue的组件概念，但Flutter中万物皆Widget
import 'components/footer_tabs.dart';

// Pages - 页面组件
// Flutter中页面也是Widget，遵循组合优于继承的原则
// 与Vue的单文件组件(.vue)不同，Flutter使用.dart文件
import 'views/common/error_page_404.dart';
import 'views/words/words_page.dart';
import 'views/game/game_car_page.dart';

// Routes - 路由配置
// 使用命名空间导入，避免命名冲突，类似于Vue的模块化导入
import 'routes/index.dart' as routes;

// Flutter应用的入口点，类似于Vue的main.js
// runApp() 是Flutter框架的启动函数，接收一个Widget作为根组件
// ProviderScope 是Riverpod的根容器，类似于Vue的createApp().use(store)
// const 关键字用于创建编译时常量，Flutter推荐使用const优化性能
void main() async {
  // 确保 Flutter 框架初始化完成
  WidgetsFlutterBinding.ensureInitialized();

  // 设置底部导航条为半透明
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // 透明背景
      systemNavigationBarContrastEnforced: false, // 不强制对比度
      systemNavigationBarIconBrightness: Brightness.dark, // 图标颜色
      statusBarColor: Colors.transparent, // 状态栏颜色
    ),
  );

  // 初始化 SharedPreferences
  // SharedPreferencesUtil 是一个工具类，用于简化 SharedPreferences 的使用
  await SharedPreferencesUtil.init();

  runApp(const ProviderScope(child: MyApp())); // 启动应用
}

// 定义全局变量 - 当前选中的底部导航索引
// 注意：这里使用全局变量不是最佳实践，正确做法应该使用状态管理
// 在Vue中，我们会将这类状态放在Vuex/Pinia中管理
// Flutter推荐使用Provider/Riverpod进行状态管理，避免全局变量
int currentIndex = 0;

// 底部导航点击处理函数
// 在Flutter中，事件处理通常通过回调函数实现
// 类似于Vue的methods中的方法，但Flutter更偏向函数式编程
void onTap(int index) {
  currentIndex = index; // 更新当前索引
  // 调试输出 - 仅在调试模式下执行
  if (kDebugMode) {
    print('当前索引: $currentIndex');
  }

  // 根据索引跳转到对应的路由
  // 使用switch语句进行路由导航，类似于Vue Router的push方法
  // router.go() 是GoRouter的声明式导航，类似于Vue Router的push
  switch (index) {
    case 0:
      router.go('/words');
      break;
    case 1:
      router.go('/learn');
      break;
    case 2:
      router.go('/game');
      break;
    case 3:
      router.go('/store');
      break;
    case 4:
      router.go('/mine');
      break;
    default:
      break;
  }
}

// 定义全局路由配置 - 使用final关键字创建运行时常量
// GoRouter是Flutter官方推荐的路由解决方案，基于"声明式路由"思想
// 与Vue Router不同，Flutter路由更注重"导航栈"管理，而不是URL状态
final GoRouter router = GoRouter(
  // 应用启动时的初始路由，类似于Vue Router的默认路由
  initialLocation: '/words',

  // 路由配置数组，类似于Vue Router的routes配置
  routes: [
    // ShellRoute - 嵌套路由的高级用法（已注释）
    // 类似于Vue Router的嵌套路由，可以为一组路由提供共同的布局
    // 这里如果启用，可以避免每个路由都包装PageWithBottomNavBar
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return PageWithBottomNavBar(child: child);
    //   },
    //   routes: [
    //     // 子路由会自动继承父级的布局
    //   ],
    // ),

    // 主要路由配置 - 每个GoRoute代表一个页面
    // Flutter的路由是基于"页面栈"的概念，不同于Vue的单页面应用
    GoRoute(
      path: '/words', // 路由路径，类似于Vue Router的path
      // pageBuilder用于构建页面，提供更多自定义选项
      // 类似于Vue Router的component，但Flutter可以完全自定义页面转场
      pageBuilder: (context, state) {
        // NoTransitionPage - 无转场动画的页面
        // Flutter默认有页面转场动画，这里禁用以提升性能
        // 类似于Vue Router的transition配置
        return NoTransitionPage(
          // PageWithBottomNavBar - 带底部导航的页面布局
          // 这是一个布局组件，类似于Vue中的Layout组件
          child: PageWithBottomNavBar(child: const WordsPage()),
        );
      },
    ),

    GoRoute(
      path: '/learn', // 路由路径，类似于Vue Router的path
      // pageBuilder用于构建页面，提供更多自定义选项
      // 类似于Vue Router的component，但Flutter可以完全自定义页面转场
      pageBuilder: (context, state) {
        // NoTransitionPage - 无转场动画的页面
        // Flutter默认有页面转场动画，这里禁用以提升性能
        // 类似于Vue Router的transition配置
        return NoTransitionPage(
          // PageWithBottomNavBar - 带底部导航的页面布局
          // 这是一个布局组件，类似于Vue中的Layout组件
          child: PageWithBottomNavBar(child: const NotFoundPage()),
        );
      },
    ),

    GoRoute(
      path: '/game',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: PageWithBottomNavBar(
            child: GameCarPage(), // 这里可以替换为实际的通讯录页面组件
          ),
        );
      },
    ),

    GoRoute(
      path: '/store',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: PageWithBottomNavBar(child: const NotFoundPage()),
        );
      },
    ),

    // 我的页面路由
    GoRoute(
      path: '/mine',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          child: PageWithBottomNavBar(child: const NotFoundPage()),
        );
      },
    ),

    // 其他路由 - 使用展开运算符合并路由配置
    // 类似于Vue中的路由模块化，将路由配置分散到不同文件中管理
    // ...语法是Dart的展开运算符，类似于JavaScript的...spread
    ...routes.routes, // 引入其他路由
  ],
);

// 带底部导航栏的页面布局组件
// 继承自ConsumerWidget，这是Riverpod提供的有状态Widget基类
// 类似于Vue中使用Vuex/Pinia的组件，可以响应状态变化
class PageWithBottomNavBar extends ConsumerWidget {
  // final关键字声明不可变属性，Flutter推荐不可变性
  // 类似于Vue中的props，但Flutter更严格地要求不可变
  final Widget child;

  // 构造函数，super.key用于Widget的性能优化
  // required关键字确保必传参数，类似于Vue的required props
  const PageWithBottomNavBar({super.key, required this.child});

  // build方法是Widget的核心，类似于Vue的render函数
  // 每当状态变化时，Flutter会重新调用build方法重建UI
  // 这与Vue的虚拟DOM更新机制不同，Flutter直接重建Widget树
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 返回Scaffold - Flutter的页面脚手架组件
    // 类似于Vue中的页面布局组件，提供了AppBar、Body、BottomNavigationBar等槽位
    // Scaffold常用属性：
    // - appBar: 顶部应用栏，类似于Vue的header组件
    // - body: 主体内容区域，必需属性，类似于Vue的main区域
    // - bottomNavigationBar: 底部导航栏，类似于Vue的footer组件
    // - floatingActionButton: 悬浮按钮，Material Design的特色组件
    // - drawer: 左侧抽屉菜单，类似于Vue的侧边栏
    // - endDrawer: 右侧抽屉菜单
    // - backgroundColor: 背景色，支持主题切换
    // - resizeToAvoidBottomInset: 键盘弹出时是否调整布局，默认true
    return Scaffold(
      // 背景色使用主题中的脚手架背景色，支持主题切换
      backgroundColor: Colors.white, // theme.scaffoldBackgroundColor,
      // 页面主体内容，类似于Vue中的<slot />
      body: child,
      // 底部导航栏 - 传递当前索引和点击回调
      bottomNavigationBar: BottomTabs(
        currentIndex: currentIndex, // 当前选中的tab索引
        // onTap回调函数 - Flutter中事件处理基于回调函数
        // 类似于Vue的@click事件，但Flutter更偏向函数式编程
        onTap: (index) {
          currentIndex = index; // 更新全局状态
          // 调试输出 - 仅在调试模式下执行
          if (kDebugMode) {
            print('当前索引: $currentIndex');
          }

          onTap(currentIndex); // 调用路由跳转函数
        },
      ),
    );
  }
}

// 主应用组件 - 应用的根Widget
// 继承自ConsumerWidget，可以监听Riverpod状态变化
// 类似于Vue中的App.vue根组件，但Flutter中所有组件都是Widget
class MyApp extends ConsumerWidget {
  // 构造函数，使用const创建编译时常量，优化性能
  const MyApp({super.key});

  // build方法构建应用的根UI
  // context提供了Widget树的上下文信息，类似于Vue的this.$parent
  // ref用于访问Riverpod的状态，类似于Vue的this.$store
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 返回SystemThemeListener包装MaterialApp.router
    // 用于监听系统主题变化并自动更新应用主题
    return MaterialApp.router(
      // 路由配置 - 使用GoRouter进行路由管理
      // 类似于Vue Router的配置，但Flutter的路由更注重导航栈
      routerConfig: router,

      // 国际化配置 - 设置应用语言为中文
      // 类似于Vue i18n的locale配置
      locale: const Locale('zh', 'CN'),

      // 关闭右上角的调试标签 - 仅在开发模式下显示
      // 类似于Vue的开发模式标识，但Flutter更加明显
      debugShowCheckedModeBanner: false, // 去掉右上角的 debug 标签
      // 主题配置 - 使用状态管理中的主题
      // Flutter的主题系统基于Material Design，支持完整的主题切换
      // 类似于Vue的全局样式，但Flutter的主题更加系统化和类型安全
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
