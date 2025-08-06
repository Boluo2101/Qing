// UI
import 'package:flutter/material.dart';

// Components
import '../../components/header_bar.dart';
import '../../components/tabs.dart';

// Routers
import 'package:go_router/go_router.dart';

// APIs
import '../../services/books_service.dart';

// 类似于Vue的localStorage，但Flutter提供了更强大的类型支持
import '../../tools/shared_preferences_util.dart';

// Providers
import '../../providers/books.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksPage extends ConsumerStatefulWidget {
  const BooksPage({super.key});

  @override
  ConsumerState<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends ConsumerState<BooksPage> {
  List<Map<String, dynamic>>? booksList; // 课程列表

  int tabIndex = 0; // 当前选中的标签索引
  int subTabIndex = 0; // 当前选中的子标签索引

  @override
  void initState() {
    super.initState();
    _loadAllBooks();
  }

  Future<void> _loadAllBooks() async {
    try {
      final books = await BooksService.getAllBooks();
      print('获取到的课程列表: $books');
      setState(() {
        booksList = books;

        // 同时更新到状态管理
        ref.read(booksProvider.notifier).updateBooks(books);
      });
    } catch (e) {
      print('加载课程列表失败: $e');
    }
  }

  // 根据字符串返回不同的颜色
  Color getColorByStr(String str) {
    switch (str) {
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'pink':
        return Colors.pink;
      case 'orange':
        return Colors.orange;
      case 'teal':
        return Colors.teal;
      default:
        return Colors.grey; // 默认颜色
    }
  }

  void clickBook(Map<String, dynamic> book) {
    // 点击课程卡片，跳转到课程详情页
    print('点击了课程: ${book['name']}');

    // 更新当前选中的书籍状态
    ref.read(booksProvider.notifier).selectBook(book);

    // show toast
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('已选择课程: ${book['name']}'),
        duration: Duration(seconds: 2),
      ),
    );

    // back
    context.pop(); // 返回上一页，类似于Vue的this.$router.back()
  }

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
      body: Column(
        children: [
          Tabs(
            currentIndex: tabIndex,
            tabsList: [
              {'key': 'all', 'label': '全部'},
              {'key': '2', 'label': '小语种'},
              {'key': '3', 'label': '专业'},
              {'key': '4', 'label': '大学'},
              {'key': '5', 'label': '高中'},
              {'key': '6', 'label': '初中'},
              {'key': '7', 'label': '小学'},
            ],
            onTap: (index) {
              // 处理底部导航栏的点击事件
              print('当前选中的索引: $index');
              setState(() {
                tabIndex = index;
              });
            },
          ),
          Tabs(
            style: 'tag',
            tabsList: [
              {'key': '1', 'label': '日语'},
              {'key': '2', 'label': '汉语'},
              {'key': '3', 'label': '法语'},
              {'key': '4', 'label': '西班牙语'},
              {'key': '5', 'label': '德语'},
              {'key': '6', 'label': '俄语'},
              {'key': '7', 'label': '阿拉伯语'},
              {'key': '8', 'label': '葡萄牙语'},
            ],
            currentIndex: subTabIndex,
            onTap: (index) {
              // 处理底部导航栏的点击事件
              print('当前选中的索引: $index');
              setState(() {
                subTabIndex = index;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: booksList?.length ?? 0,
              itemBuilder: (context, index) {
                final book = booksList![index];
                return InkWell(
                  onTap: () {
                    // 点击课程卡片，跳转到课程详情页
                    print('点击了课程 $index');
                    // GoRouter.of(context).push('/course/${book['id']}');
                    clickBook(book);
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.book_sharp,
                          size: 90,
                          color: getColorByStr(book['color'] ?? 'default'),
                        ),
                        SizedBox(width: 0),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    book['name'] ?? '未知课程',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),

                              // Progress bar
                              LinearProgressIndicator(
                                value: 0.5, // 假设进度为50%
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  getColorByStr(
                                    book['color'] ?? 'default',
                                  ).withOpacity(0.5),
                                ),
                              ),

                              SizedBox(height: 5),

                              // Progress Text
                              Text(
                                book['description'] ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
