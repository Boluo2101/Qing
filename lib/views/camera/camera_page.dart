// UI
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:ui';
// Tools
import 'package:flutter/services.dart';

class CameraPage extends StatefulWidget {
  final String? courseId;

  const CameraPage({Key? key, this.courseId}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  bool _isLoading = true;
  String? _error;

  // 底部apps，4个
  static const List<Map<String, dynamic>> _bottomApps = [
    {'icon': Icons.phone, 'label': '通话', 'color': Colors.lightGreenAccent},
    {
      'icon': Icons.explore_sharp,
      'label': '浏览器',
      'color': Colors.lightBlueAccent,
    },
    {
      'icon': Icons.mark_as_unread_sharp,
      'label': '短信',
      'color': Colors.tealAccent,
    },
    {'icon': Icons.music_note, 'label': '音乐', 'color': Colors.pinkAccent},
  ];

  // Apps
  static const List<Map<String, dynamic>> _apps = [
    {'icon': Icons.phone, 'label': '电话', 'color': Colors.lightGreenAccent},
    {'icon': Icons.message, 'label': '信息', 'color': Colors.tealAccent},
    {'icon': Icons.email, 'label': '邮件', 'color': Colors.lightBlueAccent},
    {'icon': Icons.language, 'label': '浏览器', 'color': Colors.indigoAccent},
    {'icon': Icons.photo_camera, 'label': '相机', 'color': Colors.blueGrey},
    {'icon': Icons.photo_library, 'label': '相册', 'color': Colors.redAccent},
    {'icon': Icons.music_note, 'label': '音乐', 'color': Colors.pinkAccent},
    {'icon': Icons.videocam, 'label': '视频', 'color': Colors.deepOrangeAccent},
    {'icon': Icons.calendar_today, 'label': '日历', 'color': Colors.orangeAccent},
    {'icon': Icons.map, 'label': '地图', 'color': Colors.lightGreenAccent},
    {'icon': Icons.alarm, 'label': '时钟', 'color': Colors.deepPurpleAccent},
    {'icon': Icons.calculate, 'label': '计算器', 'color': Colors.indigoAccent},
    {'icon': Icons.note, 'label': '备忘录', 'color': Colors.amberAccent},
    {'icon': Icons.contact_phone, 'label': '通讯录', 'color': Colors.orangeAccent},
    {'icon': Icons.settings, 'label': '设置', 'color': Colors.blueGrey},
    {'icon': Icons.folder, 'label': '文件', 'color': Colors.cyanAccent},
    {'icon': Icons.cloud, 'label': '云盘', 'color': Colors.lightBlueAccent},
    {
      'icon': Icons.shopping_cart,
      'label': '商店',
      'color': Colors.lightBlueAccent,
    },
    {'icon': Icons.book, 'label': '图书', 'color': Colors.deepOrangeAccent},
    {'icon': Icons.podcasts, 'label': '播客', 'color': Colors.purpleAccent},
    {'icon': Icons.health_and_safety, 'label': '健康', 'color': Colors.redAccent},
    {'icon': Icons.wallet, 'label': '钱包', 'color': Colors.black},
    {
      'icon': Icons.sports_esports,
      'label': '游戏',
      'color': Colors.deepPurpleAccent,
    },
    {'icon': Icons.school, 'label': '学习', 'color': Colors.tealAccent},
  ];

  @override
  void initState() {
    super.initState();

    // 设置状态栏字体为白色
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.green, // 设置状态栏背景色
        statusBarIconBrightness: Brightness.light, // 状态栏图标为白色
      ),
    );

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        setState(() {
          _error = '未找到可用摄像头';
          _isLoading = false;
        });
        return;
      }

      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.low, // 使用最低精度
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420, // 使用最低能耗的图像格式
      );

      await _controller!.initialize();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = '摄像头初始化失败: $e';
        _isLoading = false;
      });
    }
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      ),
    );
  }

  Widget _buildAppsGrid() {
    return Expanded(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(), // 禁止滚动
        crossAxisCount: 4,
        padding: const EdgeInsets.all(18),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
        children: _apps.map((app) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: _buildAppIcon(app)),
              const SizedBox(height: 4),
              Text(
                app['label'],
                style: const TextStyle(color: Colors.white, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAppIcon(Map<String, dynamic> app) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [app['color'].withOpacity(1.0), app['color'].withOpacity(1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        app['icon'] as IconData,
        color: Colors.white,
        size: 48,
      ), // 减少图标大小从 48 到 40
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _bottomApps.map((app) {
            return _buildAppIcon(app);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('返回'),
              ),
            ],
          ),
        ),
      );
    }

    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: Text('摄像头未初始化')));
    }

    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false), // 移除果冻效果
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 第一层：摄像头预览背景
            CameraPreview(_controller!),

            // 第二层：完整的毛玻璃覆盖层
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(color: Colors.white.withOpacity(0.02)),
            ),

            // 第三层：前景内容区域
            SafeArea(
              child: Column(
                children: [_buildTopBar(), _buildAppsGrid(), _buildBottomBar()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 恢复透明状态栏
        statusBarIconBrightness: Brightness.dark, // 恢复默认图标颜色
        statusBarBrightness: Brightness.light, // 恢复默认亮度
      ),
    );

    super.dispose();
  }
}
