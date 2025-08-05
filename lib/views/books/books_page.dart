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
  int tabIndex = 0; // 当前选中的标签索引
  int subTabIndex = 0; // 当前选中的子标签索引

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
              itemCount: 20, // 假设有20个课程
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // 点击课程卡片，跳转到课程详情页
                    print('点击了课程 $index');
                    GoRouter.of(context).push('/course/$index');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.book_sharp,
                        size: 90,
                        color: Colors.blueAccent,
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
                                  '或许没用的知识增加了',
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
                                Colors.lightBlueAccent.withOpacity(0.5),
                              ),
                            ),

                            SizedBox(height: 5),

                            // Progress Text
                            Text(
                              '收录N1级别重点单词收录N1级别重点单词收录N1级别重点单词收录N1级别重点单词收录N1级别重点单词收录N1级别重点单词',
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
