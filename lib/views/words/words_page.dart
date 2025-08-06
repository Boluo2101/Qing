// UI
import 'package:flutter/material.dart';
import '../../tools/custom_colors.dart';

// Tools
import 'dart:math';

// Routers
import 'package:go_router/go_router.dart';

// Components
import 'header_component.dart';

// 类似于Vue的localStorage，但Flutter提供了更强大的类型支持
import '../../tools/shared_preferences_util.dart';

// Providers
import '../../providers/books.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordsPage extends ConsumerStatefulWidget {
  const WordsPage({super.key});

  @override
  ConsumerState<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends ConsumerState<WordsPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // 返回渐变颜色数组
  List<Color> getGradientColorsByColor(Color color) {
    return [color, Color(0xFFF5F5F5), Color(0xFFF5F5F5)];
  }

  @override
  Widget build(BuildContext context) {
    // 添加调试信息
    final double colorLerpValue = (_scrollOffset / 60).clamp(0.0, 1);
    final Color appBarBgColor = Color.lerp(
      Colors.white.withOpacity(0.0), // 透明的白色而不是透明的黑色
      Colors.white.withOpacity(1.0),
      colorLerpValue,
    )!;

    final booksState = ref.watch(booksProvider);
    final currentBook = booksState.currentBook;

    return Scaffold(
      body: Stack(
        children: [
          // 主要内容区域
          Container(
            // 渐变背景色
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: getGradientColorsByColor(
                  CustomColors.getColorByStr(
                    currentBook?['color'] ?? 'default',
                  ),
                ),
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListView(
              controller: _scrollController,
              children: [
                // 为顶部预留空间
                SizedBox(height: 50),
                // Current Book
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book Info
                      Row(
                        children: [
                          Icon(
                            Icons.book_sharp,
                            size: 90,
                            color: CustomColors.getColorByStr(
                              currentBook?['color'] ?? 'default',
                            ),
                          ),
                          SizedBox(width: 0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      currentBook?['name'] ?? '未知课程',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        // 在这里添加修改逻辑
                                        GoRouter.of(context).push('/books');
                                      },
                                      child: Text(
                                        '修改',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_outlined,
                                      size: 12,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),

                                // Progress bar
                                LinearProgressIndicator(
                                  value: 0.5, // 假设进度为50%
                                  backgroundColor: Colors.grey[200],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    CustomColors.getColorByStr(
                                      currentBook?['color'] ?? 'default',
                                    ).withOpacity(0.5),
                                  ),
                                ),

                                SizedBox(height: 10),

                                // Progress Text
                                Text(
                                  currentBook?['description'] ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),

                      // Statistics
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('需新学'),
                                  SizedBox(height: 5),
                                  Text(
                                    '1000',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('需复习'),
                                  SizedBox(height: 5),
                                  Text(
                                    '1000',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      // fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Buttons
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: CustomColors.getColorByStr(
                              currentBook?['color'] ?? 'default',
                            ),
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            print('开始学习');
                            // 在这里添加开始学习的处理逻辑
                            GoRouter.of(
                              context,
                            ).push('/course/${currentBook?['id']}');
                          },
                          child: Text(
                            '开始学习吧!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Grids
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.border_all_outlined,
                                size: 34,
                                color: Color(0xFF000000),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '阅读提升',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.border_all_outlined,
                                size: 34,
                                color: Color(0xFF000000),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '阅读提升',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.border_all_outlined,
                                size: 34,
                                color: Color(0xFF000000),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '阅读提升',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.border_all_outlined,
                                size: 34,
                                color: Color(0xFF000000),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '阅读提升',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // List
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Java编程 未来新语言',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '每天20分钟 零基础学第二门语言',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.image_search_sharp,
                              size: 80,
                              color: Colors.deepOrange,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'JavaScript编程 未来新语言',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '每天20分钟 零基础学第二门语言',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.image_search_sharp,
                              size: 80,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Python编程 未来新语言',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '每天20分钟 零基础学第二门语言',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.image_search_sharp,
                              size: 80,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Python编程 未来新语言',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '每天20分钟 零基础学第二门语言',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.image_search_sharp,
                              size: 80,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Python编程 未来新语言',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '每天20分钟 零基础学第二门语言',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.image_search_sharp,
                              size: 80,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 固定在顶部的Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: appBarBgColor, // 使用计算的背景色
              child: WordsHeader(_scrollOffset),
            ),
          ),
        ],
      ),
    );
  }
}
