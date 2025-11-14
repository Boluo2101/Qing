// UI
import 'package:flutter/material.dart';
import 'dart:math' as math;

// Tools
import 'package:go_router/go_router.dart';

// Components
import '../../components/header_bar.dart';

class MedalPage extends StatelessWidget {
  MedalPage({super.key});

  static const Map<String, Color> _typeColors = {
    'gold': Colors.amberAccent,
    'silver': Colors.grey,
    'bronze': Colors.brown,
  };

  static const double _medalSize = 170.0;
  static const int _crossAxisCount = 3;
  static const double _padding = 16.0;

  final List<Map<String, dynamic>> medals = [
    {
      'name': '完美阅读周',
      'description': ['连续 7 天阅读,累计时长达 10 小时', '2025 年第 1 周 - 18,888 位同学获得'],
      'styleType': 'gold',
      'displayText': '1',
      'innerColor': Colors.redAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '学习达人',
      'description': ['单日学习时长超过 5 小时', '累计 12,345 位同学获得'],
      'styleType': 'silver',
      'displayText': '赞',
      'innerColor': Colors.blueAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '坚持不懈',
      'description': ['连续签到 30 天', '2025 年 1 月 - 8,888 位同学获得'],
      'styleType': 'bronze',
      'displayText': '30',
      'innerColor': Colors.orangeAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '阅读先锋',
      'description': ['累计阅读 100 本书籍', '全站前 1000 名获得'],
      'styleType': 'gold',
      'displayText': '100',
      'innerColor': Colors.purpleAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '知识探索者',
      'description': ['完成 50 个课程学习', '累计 5,678 位同学获得'],
      'styleType': 'silver',
      'displayText': '50',
      'innerColor': Colors.tealAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '早起鸟',
      'description': ['连续 7 天早晨 6 点前开始学习', '2025 年第 5 周 - 3,456 位同学获得'],
      'styleType': 'bronze',
      'displayText': '🌅',
      'innerColor': Colors.amberAccent,
      'textOpacity': 0.9,
    },
    {
      'name': '月度冠军',
      'description': ['月度学习时长第一名', '2025 年 2 月 - 仅 1 位同学获得'],
      'styleType': 'gold',
      'displayText': '👑',
      'innerColor': Colors.yellowAccent,
      'textOpacity': 0.9,
    },
    {
      'name': '笔记大师',
      'description': ['累计记录 500 条学习笔记', '累计 4,321 位同学获得'],
      'styleType': 'silver',
      'displayText': '500',
      'innerColor': Colors.cyanAccent,
      'textOpacity': 0.3,
      'medalType': 'hexagon',
    },
    {
      'name': '互助之星',
      'description': ['帮助他人解答 100 个问题', '累计 2,234 位同学获得'],
      'styleType': 'gold',
      'displayText': '💡',
      'innerColor': Colors.lightGreenAccent,
      'textOpacity': 0.9,
    },
    {
      'name': '专注力MAX',
      'description': ['单次学习专注时长超过 2 小时', '累计 15,678 位同学获得'],
      'styleType': 'bronze',
      'displayText': '⏱️',
      'innerColor': Colors.deepOrangeAccent,
      'textOpacity': 0.9,
    },
    {
      'name': '年度学霸',
      'description': ['年度累计学习 1000 小时', '2024 年 - 仅 256 位同学获得'],
      'styleType': 'gold',
      'displayText': '1K',
      'innerColor': Colors.pinkAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '课程收割者',
      'description': ['完成全部推荐课程', '累计 6,789 位同学获得'],
      'styleType': 'silver',
      'displayText': '✓',
      'innerColor': Colors.indigoAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '打卡达人',
      'description': ['连续打卡 100 天', '累计 9,876 位同学获得'],
      'styleType': 'bronze',
      'displayText': '100',
      'innerColor': Colors.limeAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '知识分享家',
      'description': ['分享学习内容被点赞 1000 次', '累计 1,234 位同学获得'],
      'styleType': 'gold',
      'displayText': '📖',
      'innerColor': Colors.redAccent,
      'textOpacity': 0.9,
    },
    {
      'name': '速读高手',
      'description': ['一周内完成 10 本书阅读', '2025 年第 8 周 - 567 位同学获得'],
      'styleType': 'gold',
      'displayText': '10',
      'innerColor': Colors.deepPurpleAccent,
      'textOpacity': 0.3,
      'medalType': 'pentagon', // 五边形
    },
    {
      'name': '全能学者',
      'description': ['涉猎 20 个不同领域的课程', '累计 3,456 位同学获得'],
      'styleType': 'gold',
      'displayText': '20',
      'innerColor': Colors.tealAccent,
      'textOpacity': 0.3,
    },
    {
      'name': '夜猫子',
      'description': ['连续 7 天深夜学习超过 1 小时', '2025 年第 10 周 - 2,345 位同学获得'],
      'styleType': 'bronze',
      'displayText': '🌙',
      'innerColor': Colors.blueAccent,
      'textOpacity': 0.9,
    },
    {
      'name': '学习新星',
      'description': ['注册一周内完成首个里程碑', '累计 50,000 位同学获得'],
      'styleType': 'silver',
      'displayText': '⭐',
      'innerColor': Colors.amberAccent,
      'textOpacity': 0.9,
    },
  ];

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
                context.pop(); // 返回上一页，类似于Vue的this.$router.back()
              },
            ),
          ],
          rightActions: [],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(_padding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _crossAxisCount,
          mainAxisSpacing: 0,
          crossAxisSpacing: 10,
          mainAxisExtent: _medalSize,
        ),
        itemCount: medals.length,
        itemBuilder: (context, index) => _MedalCard(
          medal: medals[index],
          typeColor: _typeColors[medals[index]['styleType']]!,
        ),
      ),
    );
  }
}

class _MedalCard extends StatefulWidget {
  final Map<String, dynamic> medal;
  final Color typeColor;

  const _MedalCard({required this.medal, required this.typeColor});

  @override
  State<_MedalCard> createState() => _MedalCardState();
}

class _MedalCardState extends State<_MedalCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shadowAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _shadowAnimation = Tween<double>(begin: 10.0, end: 20.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
    _showMedalDialog(); // 新增：显示对话框
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  // 新增：显示奖牌详情对话框
  void _showMedalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _MedalDialog(medal: widget.medal, typeColor: widget.typeColor);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            _buildMedalContainer(),
            const SizedBox(height: 15),
            _buildMedalName(),
          ],
        ),
      ),
    );
  }

  Widget _buildMedalContainer() {
    final medalType = widget.medal['medalType'] ?? 'circular';

    return AnimatedBuilder(
      animation: _shadowAnimation,
      builder: (context, child) {
        if (medalType == 'hexagon') {
          return _buildHexagonMedal();
        }

        if (medalType == 'pentagon') {
          return _buildPentagonMedal();
        }

        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: widget.typeColor.withOpacity(0.3),
              width: 3,
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white.withOpacity(0.05),
                widget.typeColor.withOpacity(0.2),
                widget.typeColor.withOpacity(0.7),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.typeColor.withOpacity(_isPressed ? 0.3 : 0.05),
                blurRadius: _shadowAnimation.value,
                offset: Offset(-5, _isPressed ? 8 : 5),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [_buildCircularText(), _buildInnerCircle()],
          ),
        );
      },
    );
  }

  Widget _buildHexagonMedal() {
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        size: const Size(120, 120),
        painter: HexagonPainter(
          color: widget.typeColor,
          isPressed: _isPressed,
          shadowBlur: _shadowAnimation.value,
        ),
        child: Center(
          child: Text(
            widget.medal['displayText'],
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w100,
              color: Colors.black.withOpacity(
                widget.medal['textOpacity'] ?? 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPentagonMedal() {
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        size: const Size(120, 120),
        painter: PentagonPainter(
          color: widget.typeColor,
          isPressed: _isPressed,
          shadowBlur: _shadowAnimation.value,
        ),
        child: Center(
          child: Text(
            widget.medal['displayText'],
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w100,
              color: Colors.black.withOpacity(
                widget.medal['textOpacity'] ?? 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularText() {
    const text = "PERFECTWEEK-2025";
    const radius = 50.0; // 使用与 dialog 相同的半径
    final textLength = text.length;

    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        children: List.generate(textLength, (index) {
          final angle = (2 * math.pi / textLength) * index - math.pi / 2;
          final x = radius + radius * math.cos(angle);
          final y = radius + radius * math.sin(angle);

          return Positioned(
            left: x - 3,
            top: y - 6,
            child: Transform.rotate(
              angle: angle + math.pi / 3,
              child: Text(
                text[index],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w200,
                  color: widget.typeColor.withOpacity(0.8),
                  // letterSpacing: 1,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInnerCircle() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white.withOpacity(0.3),
            widget.medal['innerColor']!.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: widget.typeColor.withOpacity(0.3), width: 2),
      ),
      child: Center(
        child: Text(
          widget.medal['displayText'],
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w100,
            color: Colors.black.withOpacity(widget.medal['textOpacity'] ?? 0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildMedalName() {
    return Text(
      widget.medal['name'],
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12, color: Colors.grey),
    );
  }
}

// 新增：奖牌对话框 Widget
class _MedalDialog extends StatefulWidget {
  final Map<String, dynamic> medal;
  final Color typeColor;

  const _MedalDialog({required this.medal, required this.typeColor});

  @override
  State<_MedalDialog> createState() => _MedalDialogState();
}

class _MedalDialogState extends State<_MedalDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // 启动动画，循环2次
    _rotationController.forward();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 3D旋转的奖牌图标
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                final angle = _rotationAnimation.value * 2 * math.pi;
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // 透视效果
                    ..rotateY(angle), // Y轴旋转
                  alignment: Alignment.center,
                  child: _buildMedalWithText(),
                );
              },
            ),
            const SizedBox(height: 30),
            // 奖牌名称
            Text(
              widget.medal['name'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // 描述信息
            ...((widget.medal['description'] as List<String>).map((desc) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              );
            }).toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildMedalWithText() {
    final medalType = widget.medal['medalType'] ?? 'circular';

    if (medalType == 'hexagon') {
      return SizedBox(
        width: 180,
        height: 180,
        child: CustomPaint(
          size: const Size(180, 180),
          painter: HexagonPainter(
            color: widget.typeColor,
            isPressed: false,
            shadowBlur: 10,
          ),
          child: Center(
            child: Text(
              widget.medal['displayText'],
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w100,
                color: Colors.black.withOpacity(
                  widget.medal['textOpacity'] ?? 0.3,
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (medalType == 'pentagon') {
      return SizedBox(
        width: 180,
        height: 180,
        child: CustomPaint(
          size: const Size(180, 180),
          painter: PentagonPainter(
            color: widget.typeColor,
            isPressed: false,
            shadowBlur: 10,
          ),
          child: Center(
            child: Text(
              widget.medal['displayText'],
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w100,
                color: Colors.black.withOpacity(
                  widget.medal['textOpacity'] ?? 0.3,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: widget.typeColor.withOpacity(0.3), width: 4),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white.withOpacity(0.05),
            widget.typeColor.withOpacity(0.2),
            widget.typeColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildCircularText(),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white.withOpacity(0.3),
                  widget.medal['innerColor']!.withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: widget.typeColor.withOpacity(0.3),
                width: 3,
              ),
            ),
            child: Center(
              child: Text(
                widget.medal['displayText'],
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w100,
                  color: Colors.black.withOpacity(
                    widget.medal['textOpacity'] ?? 0.3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularText() {
    const text = "PERFECTWEEK2025-2026";
    const radius = 75.0;
    final textLength = text.length;

    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        children: List.generate(textLength, (index) {
          final angle = (2 * math.pi / textLength) * index - math.pi / 2;
          final x = radius + radius * math.cos(angle);
          final y = radius + radius * math.sin(angle);

          return Positioned(
            left: x - 5,
            top: y - 10,
            child: Transform.rotate(
              angle: angle + math.pi / 2,
              child: Text(
                text[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  color: widget.typeColor.withOpacity(0.5),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// 新增：六边形绘制器
class HexagonPainter extends CustomPainter {
  final Color color;
  final bool isPressed;
  final double shadowBlur;

  HexagonPainter({
    required this.color,
    required this.isPressed,
    required this.shadowBlur,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) * 1; // 调整半径为容器的90%，确保宽度一致
    final path = Path();

    // 绘制六边形路径
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // 阴影
    canvas.drawShadow(
      path,
      color.withOpacity(isPressed ? 0.3 : 0.05),
      shadowBlur,
      false,
    );

    // 渐变填充
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.white.withOpacity(0.05),
        color.withOpacity(0.2),
        color.withOpacity(0.9),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // 边框
    final borderPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(HexagonPainter oldDelegate) {
    return oldDelegate.isPressed != isPressed ||
        oldDelegate.shadowBlur != shadowBlur;
  }
}

// 新增：五边形绘制器
class PentagonPainter extends CustomPainter {
  final Color color;
  final bool isPressed;
  final double shadowBlur;

  PentagonPainter({
    required this.color,
    required this.isPressed,
    required this.shadowBlur,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) * 1;
    final path = Path();

    // 绘制五边形路径（顶点朝上）
    for (int i = 0; i < 5; i++) {
      final angle = (2 * math.pi / 5) * i - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // 阴影
    canvas.drawShadow(
      path,
      color.withOpacity(isPressed ? 0.3 : 0.05),
      shadowBlur,
      false,
    );

    // 渐变填充
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.white.withOpacity(0.05),
        color.withOpacity(0.2),
        color.withOpacity(0.9),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // 边框
    final borderPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(PentagonPainter oldDelegate) {
    return oldDelegate.isPressed != isPressed ||
        oldDelegate.shadowBlur != shadowBlur;
  }
}
