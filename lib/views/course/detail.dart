// UI
import 'package:flutter/material.dart';

// Tools
import 'package:intl/intl.dart';

// Routers
import 'package:go_router/go_router.dart';

// Components
import '../../components/header_bar.dart';

// APIs
import '../../services/books_service.dart';

// CONFIGs
import '../../configs/configs.dart';

// 类似于Vue的localStorage，但Flutter提供了更强大的类型支持
import '../../tools/shared_preferences_util.dart';

class CourseDetailPage extends StatefulWidget {
  final String? courseId;

  const CourseDetailPage({Key? key, this.courseId}) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  List<Map<String, dynamic>>? courseData;
  bool isLoading = true;
  String? errorMessage;

  int arrayIndex = 0; // 用于跟踪当前课程的索引
  bool showDetails = false; // 用于控制是否显示课程详情
  bool showContent = false; // 用于控制是否显示课程内容
  Map<String, dynamic>? currentObjByIndex;

  @override
  void initState() {
    super.initState();
    _loadCourseDetail();
  }

  Future<void> _loadCourseDetail() async {
    if (widget.courseId == null) {
      setState(() {
        errorMessage = '课程ID不能为空';
        isLoading = false;
      });
      return;
    }

    try {
      final data = await BooksService.getBookDetailsById(widget.courseId!);
      setState(() {
        arrayIndex = 0; // 重置索引
        showContent = false;
        showDetails = false;

        courseData = data;
        currentObjByIndex = courseData![arrayIndex];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = '加载课程详情失败: ${e.toString()}';
        print(errorMessage);
        isLoading = false;
      });
    }
  }

  void _addEnergyPoints({int num = 1}) {
    // 增加能量点的逻辑
    int newPoints = (SharedPreferencesUtil.getInt('energyPoints') ?? 0) + num;
    SharedPreferencesUtil.setInt('energyPoints', newPoints);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          borderShow: false,
          title: '',
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
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        // Styles - 样式配置
        backgroundColor: Colors.white, // 使用自定义主题色
        type: BottomNavigationBarType.fixed, // 固定类型的底部导航栏
        showUnselectedLabels: false, // 显示未选中的标签
        showSelectedLabels: false, // 显示选中的标签
        iconSize: 24, // 图标大小
        selectedItemColor: Colors.grey, // 使用主题主色
        unselectedItemColor: Colors.grey, // 使用主题色系
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chevron_left_sharp,
              color: arrayIndex >= 1
                  ? Colors.grey
                  : Colors.grey.shade300, // 根据条件改变颜色
            ),
            label: '', // 空字符串标签
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chevron_right_sharp),
            label: '', // 空字符串标签
          ),
        ],
        onTap: (index) {
          if (index == 0 && arrayIndex >= 1) {
            // 上一页逻辑
            setState(() {
              showDetails = false;
              showContent = false;
              arrayIndex--;
              currentObjByIndex = courseData![arrayIndex];
            });
          } else if (index == 1) {
            // 更新能量点缓存
            _addEnergyPoints();

            // 下一页逻辑
            setState(() {
              if (!showDetails) {
                showDetails = true;
                return;
              } else if (!showContent &&
                  currentObjByIndex!['content'] != null) {
                showContent = true;
                return;
              }

              showDetails = false;
              showContent = false;

              if (arrayIndex >= courseData!.length - 1) {
                // 如果已经是最后一页，重置到第一页
                context.pop(); // 返回上一页
              } else {
                arrayIndex++;
              }

              currentObjByIndex = courseData![arrayIndex];
            });
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCourseDetail,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (courseData == null) {
      return const Center(child: Text('没有找到课程数据'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 课程标题
          Row(
            mainAxisAlignment: !showDetails
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              SizedBox(height: !showDetails ? 160 : 0),

              Text(
                currentObjByIndex!['title'] ?? '未知课程',
                style: TextStyle(
                  fontSize: !showDetails ? 34 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 课程封面图片
          if (showDetails && currentObjByIndex!['imageUrl'] != null)
            Image.network(
              '${CONFIGs.API_HOST}/' + currentObjByIndex!['imageUrl'],
            ),

          const SizedBox(height: 16),

          // 课程描述
          if (showDetails && currentObjByIndex!['description'] != null) ...[
            Text(
              currentObjByIndex!['description'],
              style: const TextStyle(fontSize: 20, height: 1.5),
            ),
            const SizedBox(height: 16),
          ],

          // Content
          if (showContent && currentObjByIndex!['content'] != null) ...[
            Text(
              currentObjByIndex!['content'],
              style: const TextStyle(fontSize: 20, height: 1.5),
            ),
          ],
        ],
      ),
    );
  }
}
