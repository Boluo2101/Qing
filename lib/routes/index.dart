// 路由配置文件 - 管理应用的所有路由
// 类似于Vue Router的路由配置，但Flutter使用GoRouter库

// Imports - 导入依赖
// GoRouter - Flutter官方推荐的路由库，替代Navigator
import 'package:go_router/go_router.dart';
// 404页面组件
import '../views/common/error_page_404.dart';

// Pages
import '../views/course/detail.dart';
import '../views/books/books_page.dart';
import '../views/feedback/feedback_page.dart';

// 路由列表 - 定义所有应用路由
// 类似于Vue Router的routes数组，但Flutter使用GoRoute对象
// List<GoRoute>是Dart的泛型列表，类似于Vue的RouteConfig[]
final List<GoRoute> routes = [
  // 定义404页面路由 - 当访问未定义的路由时跳转到此页面
  // 类似于Vue Router的catch-all路由
  GoRoute(path: '/404', builder: (context, state) => const NotFoundPage()),

  // 所有书籍页面
  GoRoute(
    path: '/books',
    builder: (context, state) {
      return BooksPage();
    },
  ),

  // 课程学习详情页
  GoRoute(
    path: '/course/:id',
    builder: (context, state) {
      final courseId = state.pathParameters['id'];
      print('Navigating to course detail with ID: $courseId');
      return CourseDetailPage(courseId: courseId);
    },
  ),

  // 反馈页
  GoRoute(
    path: '/feedback',
    builder: (context, state) {
      return FeedbackPage();
    },
  ),
];
