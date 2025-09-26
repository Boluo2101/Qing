// Tools
import 'dart:async';
import 'package:flutter/material.dart';
import '../../tools/custom_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tools/color_extractor.dart';

// Routers
import 'package:go_router/go_router.dart';

class MusicPage extends ConsumerStatefulWidget {
  const MusicPage({super.key});

  @override
  ConsumerState<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends ConsumerState<MusicPage> {
  final List<Map<String, dynamic>> musicList = [
    {
      'title': '我们活着',
      'key': '1',
      'author': '刘牧',
      'cover': 'https://testingbot.com/free-online-tools/random-avatar/400',
    },
    {
      'title': '光辉岁月',
      'key': '2',
      'author': 'Beyond',
      'cover': 'https://testingbot.com/free-online-tools/random-avatar/500',
    },
    {
      'title': '海阔天空',
      'key': '3',
      'author': 'Beyond',
      'cover': 'https://testingbot.com/free-online-tools/random-avatar/300',
    },
    {
      'title': '喜欢你',
      'key': '4',
      'author': 'Beyond',
      'cover': 'https://testingbot.com/free-online-tools/random-avatar/700',
    },
  ];

  String keyActive = '1'; // 当前激活的音乐key
  Map<String, dynamic> musicActive = {
    'title': '我们活着',
    'key': '1',
    'author': '刘牧',
    'cover': 'https://testingbot.com/free-online-tools/random-avatar/400',
  }; // 当前激活的音乐
  Color mainColor = CustomColors.getColorByStr('yellow');
  bool playing = false; // 是否播放中
  int colorIndex = 0; // mainColor 在渐变数组中的位置
  Timer? _timer;

  // 渐变方向数组
  final List<List<Alignment>> gradientAlignments = [
    [Alignment.topLeft, Alignment.centerLeft],
    [Alignment.topLeft, Alignment.centerRight],
    [Alignment.topLeft, Alignment.bottomCenter],
    [Alignment.topLeft, Alignment.bottomRight],
    [Alignment.center, Alignment.bottomRight],
    [Alignment.centerLeft, Alignment.bottomRight],
    [Alignment.centerLeft, Alignment.bottomRight],
    [Alignment.topCenter, Alignment.bottomRight],
    [Alignment.topLeft, Alignment.bottomRight],
    [Alignment.topLeft, Alignment.centerRight],
  ];

  // 返回渐变颜色数组，mainColor 动态插入 colorIndex 位置
  List<Color> getGradientColorsByColor(Color color, int index) {
    List<Color> base = [
      Colors.white,
      Color(0xFFF5F5F5),
      Color(0xFFF5F5F5),
      Color(0xFFF5F5F5),
    ];
    base.insert(index.clamp(0, base.length), color);
    return base;
  }

  @override
  void initState() {
    super.initState();

    // 初始化定时器
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        colorIndex = (colorIndex + 1) % gradientAlignments.length; // 0~4
      });
    });

    // 初始化激活的歌曲
    musicActive = musicList.firstWhere((item) => item['key'] == keyActive);

    // 提取主色调
    getAndSetMainColor();
  }

  bool changePlaying() {
    setState(() {
      playing = !playing;
    });
    return playing;
  }

  void getAndSetMainColor() async {
    Color? color = await ColorExtractor.getMainColor(musicActive['cover']);
    if (color != null) {
      setState(() {
        mainColor = color;
      });
    }
  }

  void changeMusicActive(String type) {
    // type: pre / next
    int totalIndex = musicList.length;
    int currentIndex = musicList.indexWhere(
      (item) => item['key'] == musicActive['key'],
    );

    if (type == 'pre') {
      currentIndex = (currentIndex - 1 + totalIndex) % totalIndex;
    } else if (type == 'next') {
      currentIndex = (currentIndex + 1) % totalIndex;
    }

    musicActive = musicList[currentIndex];

    playing = true; // 切歌后自动播放

    // 提取主色调
    getAndSetMainColor();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // 顶部条
  Widget _buildHeaderBar() {
    return Positioned(
      top: 0, // 距离顶部 20px
      left: 10,
      right: 10,
      child: Container(
        height: 80,
        padding: EdgeInsets.only(top: 40, left: 0, right: 0),
        // color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 两端对齐
          mainAxisSize: MainAxisSize.max,

          children: [
            // 返回按钮
            IconButton(
              icon: Icon(Icons.close_sharp, color: Colors.grey, size: 24),
              onPressed: () {
                // 返回上一页
                context.pop();
              },
            ),

            Expanded(child: Container()),

            // 右侧按钮
            IconButton(
              icon: Icon(Icons.ios_share_sharp, color: Colors.grey, size: 24),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // 操作条
  Widget _buildActionBar() {
    return Positioned(
      bottom: 170,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // 两端对齐
        mainAxisSize: MainAxisSize.max,

        children: [
          IconButton(
            icon: Icon(Icons.mic_external_on_sharp, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.radar_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download_sharp, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.chat_sharp, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert_sharp, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 进度条
  Widget _buildProgressBar() {
    return Positioned(
      bottom: 110, //
      left: 20,
      right: 20,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300], // 背景色，半透明白色
              borderRadius: BorderRadius.circular(2), // 圆角
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.3, // 进度条宽度占比，30%
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor, // 进度条颜色
                  borderRadius: BorderRadius.circular(2), // 圆角
                ),
              ),
            ),
          ),
          SizedBox(height: 14), // 间距

          Row(
            children: [
              Text(
                '1:30',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
              Spacer(), // 占位符，撑开空间
              Text(
                '4:30',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 底部操作条
  Widget _buildBottomControlBar() {
    return Positioned(
      bottom: 0, // 距离底部 20px
      left: 0,
      right: 0,
      child: Center(
        // 配合 Center 实现水平居中
        child: SizedBox(
          height: 120,
          // color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // 两端对齐
            mainAxisSize: MainAxisSize.max,

            children: [
              // 按钮，循环 ，上一个，播放/暂停， 下一个， 列表
              IconButton(
                icon: Icon(
                  Icons.low_priority_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  // 循环
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.black, size: 30),
                onPressed: () {
                  // 上一个
                  changeMusicActive('pre');
                },
              ),
              IconButton(
                icon: Icon(
                  playing ? Icons.pause_circle_sharp : Icons.play_circle_sharp,
                  color: Colors.black,
                  size: 70,
                ),
                onPressed: () {
                  // 播放/暂停
                  changePlaying();
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, color: Colors.black, size: 30),
                onPressed: () {
                  // 下一个
                  changeMusicActive('next');
                },
              ),
              IconButton(
                icon: Icon(Icons.queue_music, color: Colors.black, size: 30),
                onPressed: () {
                  // 列表
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 主体内容
  Widget _buildBody() {
    return Positioned.fill(
      top: 100,
      bottom: 250,
      left: 20,
      right: 20,
      child: Column(
        children: [
          // 封面
          AspectRatio(
            aspectRatio: 1.0, // 宽高比 1:1（正方形）
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 0),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(musicActive['cover']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(height: 20), // 间距
          // 标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                musicActive['title'],
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),

              IconButton(
                icon: Icon(Icons.favorite, color: Colors.redAccent, size: 30),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 6), // 间距
          // 作者
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                musicActive['author'],
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(width: 10),
              _buildTag('关注'),
              SizedBox(width: 10),
              _buildTag('60人收听'),
              SizedBox(width: 10),
              _buildTag('SQ'),
              SizedBox(width: 10),
              _buildTag('原声'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 1, 5, 1), // 可选，添加内边距让文字不贴边
      decoration: BoxDecoration(
        color: Colors.grey[300], // 背景色
        borderRadius: BorderRadius.circular(10), // 圆角半径
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w200,
          color: Colors.black54,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 动画渐变背景
        AnimatedContainer(
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: getGradientColorsByColor(mainColor, colorIndex),
              begin: gradientAlignments[colorIndex][0],
              end: gradientAlignments[colorIndex][1],
            ),
          ),
        ),

        // 顶部条
        _buildHeaderBar(),

        // 内容区，自动占满剩余区域
        _buildBody(),

        // 操作条
        _buildActionBar(),

        // 进度条
        _buildProgressBar(),

        // 底部操作条
        _buildBottomControlBar(),
      ],
    );
  }
}
