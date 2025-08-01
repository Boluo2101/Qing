// UI
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

// Dart 内置扩展方法 - 更简洁的数组操作
extension IntExtensions on int {
  // 创建范围数组
  List<int> to(int end, {int step = 1}) {
    if (step > 0 && this < end) {
      return [for (int i = this; i < end; i += step) i];
    } else if (step < 0 && this > end) {
      return [for (int i = this; i > end; i += step) i];
    }
    return [];
  }

  // 倒序范围
  List<int> downTo(int end) => to(end, step: -1);
}

// List 扩展方法
extension ListExtensions<T> on List<T> {
  // 创建二维数组
  static List<List<T>> create2D<T>(int rows, int cols, T defaultValue) {
    return List.generate(rows, (_) => List.filled(cols, defaultValue));
  }

  // 创建坐标数组
  static List<List<int>> coords(List<int> rows, List<int> cols) {
    return [
      for (int row in rows)
        for (int col in cols) [row, col],
    ];
  }
}

class GameCarPage extends StatefulWidget {
  GameCarPage({super.key});

  @override
  State<GameCarPage> createState() => _GameCarPageState();
}

class _GameCarPageState extends State<GameCarPage>
    with SingleTickerProviderStateMixin {
  // === 游戏配置常量 ===
  static const int GRID_ROWS = 160;
  static const int GRID_COLS = 80;
  static const int ROAD_WIDTH = 4;
  static const int CAR_SIZE = 1;
  static const int MIN_LAKE_COUNT = 3;
  static const int MAX_LAKE_COUNT = 5;
  static const int MIN_TURN_COUNT = 3;
  static const int MAX_TURN_COUNT = 6;
  static const int ANIMATION_DURATION_SECONDS = 10; // === 游戏数据 ===
  List<List<int>> gameGrid = [];

  // 车辆行驶路径（靠右行驶）
  List<List<int>> carPath = [];

  // 道路中心线路径（用于生成车辆路径）
  List<int> roadCenterPath = [];

  // 草地颜色网格 - 存储每个格子的固定颜色索引
  List<List<int>> grassColorGrid = [];

  // 地形类型网格 - 0:草地, 1:道路, 2:湖泊
  List<List<int>> terrainGrid = [];

  // 湖泊图标数据：存储每个湖泊位置的图标信息
  List<Map<String, dynamic>> lakeIcons = [];

  // 动画控制器
  AnimationController? _animationController;
  Animation<double>? _animation;

  // 车的当前位置（左上角）
  int carRow = 160;
  int carCol = 80;

  // 车辆旋转角度（用于抖动效果）
  double carRotation = 0.0;

  // 当前车辆的图标（在初始化时确定，避免重绘时变化）
  String currentCarUnit = '🚗';

  // 当前车辆索引（用于循环选择车辆）
  int currentCarIndex = 0;

  // 动画时间（用于湖泊图标摇摆）
  double animationTime = 0.0;

  // 随机数生成器
  final Random _random = Random(); // 三种绿色供草地随机选择
  final List<Color> _grassColors = [
    Color(0xFF8BC34A), // 浅绿色
    Color(0xFF4CAF50), // 标准绿色
    Color(0xFF2E7D32), // 深绿色
  ];

  // 三种蓝色供湖泊随机选择
  final List<Color> _lakeColors = [
    Color(0xFF2196F3), // 标准蓝色
    Color(0xFF1976D2), // 深蓝色
  ];

  // 显示在湖泊里的单位
  final List<String> _lakeUnits = [
    '🌊', // 水波纹
    '🦆', // 鸭子
    '🦢', // 天鹅
    '🐠', // 鱼
    '🦈', // 鲨鱼
    '🐢', // 海龟
    '🏊', // 游泳的人
    '⛵', // 帆船
    '🚣', // 划船
    '🐤',
  ];

  // 随机选择湖泊单位
  String get randomLakeUnit => _lakeUnits[_random.nextInt(_lakeUnits.length)];

  //  车辆单位 - 优化选择，更适合道路行驶
  final List<String> _carUnits = [
    '🚗', // 小汽车
    '🚙', // SUV
    '🚕', // 出租车
    '🚚', // 卡车
    '🚛', // 大货车
    '🏎️', // 跑车
    '🚓', // 警车
    '🚑', // 救护车
    '🚒', // 消防车
    '🚐', // 面包车
    '🚚', // 皮卡
    '🚌', // 公交车
    '🚎', // 无轨电车
    '🏍️', // 摩托车
    '🚲', // 自行车
    '🛵', // 电动车/踏板车
    '🚜', // 拖拉机
  ];

  // 选择下一辆车（按顺序循环）
  void _selectNextCarUnit() {
    currentCarIndex = (currentCarIndex + 1) % _carUnits.length;
    currentCarUnit = _carUnits[currentCarIndex];
  }

  // 选择初始车辆单位（第一辆车）
  void _selectInitialCarUnit() {
    currentCarIndex = 0;
    currentCarUnit = _carUnits[currentCarIndex];
  }

  @override
  void initState() {
    super.initState();
    // 选择初始车辆单位
    _selectInitialCarUnit();

    // 初始化游戏网格（包括随机道路生成）
    _initializeGrid();

    // 直接初始化动画
    _initializeAnimation();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();

    // 恢复状态栏为默认样式
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 恢复透明状态栏
        statusBarIconBrightness: Brightness.dark, // 恢复默认图标颜色
        statusBarBrightness: Brightness.light, // 恢复默认亮度
      ),
    );
  }

  // 初始化动画
  void _initializeAnimation() {
    if (carPath.isEmpty) return; // 如果车辆路径为空，不初始化动画

    _animationController = AnimationController(
      duration: Duration(seconds: ANIMATION_DURATION_SECONDS),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: carPath.length.toDouble() - 1)
        .animate(
          CurvedAnimation(parent: _animationController!, curve: Curves.linear),
        );

    _animation!.addListener(() {
      int pathIndex = _animation!.value.round();
      if (pathIndex < carPath.length) {
        int newRow = carPath[pathIndex][0];
        int newCol = carPath[pathIndex][1];

        // 确保车不超出网格边界
        int newCarRow = newRow.clamp(0, GRID_ROWS - CAR_SIZE);
        int newCarCol = newCol.clamp(0, GRID_COLS - CAR_SIZE);

        // 计算车辆抖动角度（左右5度旋转）
        double time = _animation!.value / 10.0; // 减慢抖动频率
        double newRotation = sin(time * 2 * pi) * 5 * pi / 180; // 5度转弧度

        // 更新动画时间（用于湖泊图标摇摆）
        double newAnimationTime = _animation!.value * 0.02; // 调整摇摆频率

        // 只有在位置或旋转实际改变时才更新状态
        if (carRow != newCarRow ||
            carCol != newCarCol ||
            (carRotation - newRotation).abs() > 0.01 ||
            (animationTime - newAnimationTime).abs() > 0.001) {
          // 降低阈值以确保更新
          setState(() {
            carRow = newCarRow;
            carCol = newCarCol;
            carRotation = newRotation;
            animationTime = newAnimationTime;
          });
        }
      }
    });

    // 添加动画完成监听器，每次完成一轮时切换车辆
    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 切换到下一辆车
        _selectNextCarUnit();
        setState(() {}); // 更新UI显示新车辆
        // 重新开始动画
        _animationController!.forward(from: 0.0);
      }
    });

    // 自动开始动画
    _animationController!.forward();
  }

  // 初始化游戏网格 - 优化内存分配
  void _initializeGrid() {
    // 分批初始化，避免一次性分配过多内存
    _initializeGridArrays();
    _initializeGrassColors();

    // 分步生成内容
    _generateLakes();
    _generateRandomRoad();
    _applyTerrainCollapseAlgorithm();
  }

  // 分离数组初始化
  void _initializeGridArrays() {
    gameGrid = ListExtensions.create2D(GRID_ROWS, GRID_COLS, 0);
    terrainGrid = ListExtensions.create2D(GRID_ROWS, GRID_COLS, 0);
  }

  // 分离草地颜色初始化
  void _initializeGrassColors() {
    grassColorGrid = List.generate(
      GRID_ROWS,
      (row) => List.generate(
        GRID_COLS,
        (col) => _random.nextInt(_grassColors.length),
      ),
    );
  }

  // 生成随机道路（从右下角到左上角）
  void _generateRandomRoad() {
    roadCenterPath = []; // 重置道路中心线路径

    // 起点：右下角位置（确保道路宽度不超出边界）
    int startCol = GRID_COLS - ROAD_WIDTH ~/ 2 - 1; // 从右下角开始，确保左右各有足够空间

    // 生成路径段 - 包括垂直和水平路段
    List<Map<String, dynamic>> roadSegments = [];

    // 规划转弯点，创建水平和垂直路段
    int turnCount =
        _random.nextInt(MAX_TURN_COUNT - MIN_TURN_COUNT + 1) + MIN_TURN_COUNT;
    int currentRow = GRID_ROWS; // 从底部开始
    int currentCol = startCol;

    for (int i = 0; i <= turnCount; i++) {
      int nextRow;
      int nextCol;

      if (i == turnCount) {
        // 最后一段，直达左上角
        nextRow = 0;
        nextCol = ROAD_WIDTH ~/ 2; // 左上角位置，确保道路不超界
      } else {
        // 计算下一个转弯点
        int segmentLength = currentRow ~/ (turnCount - i + 1);
        segmentLength = segmentLength.clamp(
          GRID_ROWS ~/ 8,
          GRID_ROWS ~/ 3,
        ); // 动态调整段长度

        if (i % 2 == 0) {
          // 偶数段：垂直路段（向上）
          nextRow = currentRow - segmentLength;
          nextCol = currentCol + _random.nextInt(10) - 5; // 轻微水平偏移
          nextCol = nextCol.clamp(
            ROAD_WIDTH ~/ 2,
            GRID_COLS - ROAD_WIDTH ~/ 2 - 1,
          );
        } else {
          // 奇数段：水平路段（大弯道）
          nextRow =
              currentRow - _random.nextInt(GRID_ROWS ~/ 7) - GRID_ROWS ~/ 10;
          int horizontalDistance =
              _random.nextInt(GRID_COLS ~/ 2) + GRID_COLS ~/ 4;
          if (_random.nextBool()) {
            nextCol = currentCol + horizontalDistance;
          } else {
            nextCol = currentCol - horizontalDistance;
          }
          nextCol = nextCol.clamp(
            ROAD_WIDTH ~/ 2,
            GRID_COLS - ROAD_WIDTH ~/ 2 - 1,
          );
        }
      }

      // 添加路段
      roadSegments.add({
        'startRow': currentRow,
        'endRow': nextRow,
        'startCol': currentCol,
        'endCol': nextCol,
        'isHorizontal': i % 2 == 1,
      });

      currentRow = nextRow;
      currentCol = nextCol;

      if (currentRow <= 0) break;
    }

    // 根据路段生成道路中心线
    _generateRoadFromSegments(roadSegments);

    // 根据中心线绘制道路
    _drawRoadFromCenterPath(roadCenterPath, ROAD_WIDTH);

    // 生成车辆行驶路径（靠右行驶）
    _generateCarPathFromRoad(ROAD_WIDTH);
  }

  // 根据路段生成道路中心线
  void _generateRoadFromSegments(List<Map<String, dynamic>> segments) {
    roadCenterPath = [];

    for (var segment in segments) {
      int startRow = segment['startRow'];
      int endRow = segment['endRow'];
      int startCol = segment['startCol'];
      int endCol = segment['endCol'];
      bool isHorizontal = segment['isHorizontal'];

      if (isHorizontal) {
        // 水平路段：使用贝塞尔曲线创建平滑转弯
        int totalRows = startRow - endRow; // 注意：现在是从下到上，所以是startRow - endRow
        int horizontalDistance = endCol - startCol;

        // 确保totalRows至少为1，避免除零错误
        if (totalRows <= 0) totalRows = 1;

        for (int i = 0; i < totalRows && startRow - i >= 0; i++) {
          double t = totalRows > 1 ? i / (totalRows - 1) : 0; // 参数化时间 0-1

          // 根据转弯幅度调整控制点
          double turnSharpness =
              horizontalDistance.abs() / (GRID_COLS / 4.0); // 转弯锐度
          turnSharpness = turnSharpness.clamp(0.1, 1.0);

          // 使用三次贝塞尔曲线实现平滑转弯
          // P0 = 起点, P1 = 控制点1, P2 = 控制点2, P3 = 终点
          double p0 = startCol.toDouble();
          double p1 =
              startCol +
              horizontalDistance * (0.2 + turnSharpness * 0.1); // 控制点1：根据转弯幅度调整
          double p2 =
              endCol -
              horizontalDistance * (0.2 + turnSharpness * 0.1); // 控制点2：根据转弯幅度调整
          double p3 = endCol.toDouble();

          // 三次贝塞尔曲线公式
          double col =
              (1 - t) * (1 - t) * (1 - t) * p0 +
              3 * (1 - t) * (1 - t) * t * p1 +
              3 * (1 - t) * t * t * p2 +
              t * t * t * p3;

          int colInt = col.round().clamp(
            ROAD_WIDTH ~/ 2,
            GRID_COLS - ROAD_WIDTH ~/ 2 - 1,
          );

          int currentRow = startRow - i;
          if (currentRow >= 0 && currentRow < GRID_ROWS) {
            while (roadCenterPath.length <= currentRow) {
              roadCenterPath.add(GRID_COLS ~/ 2);
            }
            roadCenterPath[currentRow] = colInt;
          }
        }
      } else {
        // 垂直路段：使用线性插值，确保路径连续性
        int totalRows = startRow - endRow;
        if (totalRows <= 0) totalRows = 1;

        for (int row = startRow; row > endRow && row >= 0; row--) {
          double progress = totalRows > 0
              ? (startRow - row) / totalRows.toDouble()
              : 0;

          // 使用平滑的插值函数
          double smoothProgress =
              progress * progress * (3 - 2 * progress); // smoothstep函数
          int col = (startCol + (endCol - startCol) * smoothProgress).round();
          col = col.clamp(ROAD_WIDTH ~/ 2, GRID_COLS - ROAD_WIDTH ~/ 2 - 1);

          if (row >= 0 && row < GRID_ROWS) {
            while (roadCenterPath.length <= row) {
              roadCenterPath.add(GRID_COLS ~/ 2);
            }
            roadCenterPath[row] = col;
          }
        }
      }
    }

    // 确保路径覆盖所有行，并填补空隙
    while (roadCenterPath.length < GRID_ROWS) {
      roadCenterPath.add(
        roadCenterPath.isNotEmpty ? roadCenterPath.last : GRID_COLS ~/ 2,
      );
    }

    // 填补路径中的空隙（插值处理）
    for (int row = 1; row < roadCenterPath.length - 1; row++) {
      if (roadCenterPath[row] == GRID_COLS ~/ 2 &&
          roadCenterPath[row - 1] != GRID_COLS ~/ 2 &&
          roadCenterPath[row + 1] != GRID_COLS ~/ 2) {
        // 如果当前行是默认值但前后都有实际值，进行插值
        roadCenterPath[row] =
            ((roadCenterPath[row - 1] + roadCenterPath[row + 1]) / 2).round();
      }
    }
  }

  // 根据中心线绘制指定宽度的道路
  void _drawRoadFromCenterPath(List<int> centerPath, int width) {
    for (int row = 0; row < centerPath.length && row < GRID_ROWS; row++) {
      int centerCol = centerPath[row];

      // 计算当前位置的转弯角度，调整道路宽度
      int currentWidth = width;
      if (row > 0 && row < centerPath.length - 1) {
        int prevCol = centerPath[row - 1];
        int nextCol = centerPath[row + 1];
        int colDiff = (nextCol - prevCol).abs();

        // 如果转弯较急，适当增加道路宽度
        if (colDiff > 2) {
          currentWidth = (width + 1).clamp(width, width + 2);
        }
      }

      // 确保道路宽度：中心线左右各currentWidth/2格
      for (
        int col = centerCol - currentWidth ~/ 2;
        col < centerCol + currentWidth ~/ 2;
        col++
      ) {
        if (col >= 0 && col < GRID_COLS) {
          // 设置道路类型：1=普通道路，3=中心线
          if (col == centerCol) {
            gameGrid[row][col] = 3; // 中心线
          } else {
            gameGrid[row][col] = 1; // 普通道路
          }

          // // 道路不能被湖泊覆盖，清除该位置的湖泊
          // if (terrainGrid[row][col] == 2) {
          //   terrainGrid[row][col] = 0;
          // }
        }
      }
    }
  }

  // 生成车辆行驶路径（沿着道路右侧行驶，从下往上）
  void _generateCarPathFromRoad(int roadWidth) {
    carPath = [];

    // 从底部开始到顶部
    for (int row = GRID_ROWS - 1; row >= 0; row--) {
      int centerCol = roadCenterPath[row];
      // 靠右行驶：在道路右侧车道
      int carCol = centerCol; // 在中心线位置，车会占据中心右侧

      // 确保车辆不超出边界
      carCol = carCol.clamp(0, GRID_COLS - CAR_SIZE);

      carPath.add([row, carCol]);
    }

    // 设置初始位置（从底部开始）
    if (carPath.isNotEmpty) {
      carRow = carPath[0][0];
      carCol = carPath[0][1];
    }
  }

  // 生成随机湖泊
  void _generateLakes() {
    // 清空之前的湖泊图标
    lakeIcons.clear();

    int lakeCount =
        _random.nextInt(MAX_LAKE_COUNT - MIN_LAKE_COUNT + 1) + MIN_LAKE_COUNT;

    for (int i = 0; i < lakeCount; i++) {
      // 随机选择湖泊中心点（避开边缘）
      int centerRow = _random.nextInt(GRID_ROWS * 3 ~/ 4) + GRID_ROWS ~/ 8;
      int centerCol = _random.nextInt(GRID_COLS ~/ 2) + GRID_COLS ~/ 4;

      // 随机湖泊大小
      int lakeSize = _random.nextInt(3) + 2; // 2-4的半径

      // 创建圆形湖泊
      _createCircularLake(centerRow, centerCol, lakeSize);
    }
  }

  // 创建圆形湖泊
  void _createCircularLake(int centerRow, int centerCol, int radius) {
    // 记录湖泊的格子位置
    List<List<int>> lakePositions = [];

    for (int row = centerRow - radius; row <= centerRow + radius; row++) {
      for (int col = centerCol - radius; col <= centerCol + radius; col++) {
        // 检查边界
        if (row >= 0 && row < GRID_ROWS && col >= 0 && col < GRID_COLS) {
          // 计算距离中心的距离
          double distance =
              ((row - centerRow) * (row - centerRow) +
                      (col - centerCol) * (col - centerCol))
                  .toDouble();

          // 如果在圆形范围内，设置为湖泊
          if (distance <= radius * radius) {
            terrainGrid[row][col] = 2; // 2 表示湖泊
            lakePositions.add([row, col]);
          }
        }
      }
    }

    // 为这个湖泊生成1到2个随机图标，确保不重叠
    if (lakePositions.isNotEmpty) {
      int iconCount = _random.nextInt(2) + 1; // 1到2个图标
      List<List<int>> usedPositions = []; // 记录已使用的位置

      for (int i = 0; i < iconCount && lakePositions.isNotEmpty; i++) {
        // 过滤掉已使用的位置和其邻近位置
        List<List<int>> availablePositions = lakePositions.where((pos) {
          for (var usedPos in usedPositions) {
            // 计算与已使用位置的距离，确保至少间隔2格
            int rowDiff = (pos[0] - usedPos[0]).abs();
            int colDiff = (pos[1] - usedPos[1]).abs();
            if (rowDiff <= 4 && colDiff <= 4) {
              return false; // 距离太近，不可用
            }
          }
          return true;
        }).toList();

        // 如果没有可用位置，跳出循环
        if (availablePositions.isEmpty) break;

        // 随机选择一个可用位置
        List<int> iconPosition =
            availablePositions[_random.nextInt(availablePositions.length)];
        String iconUnit = _lakeUnits[_random.nextInt(_lakeUnits.length)];

        // 记录使用的位置
        usedPositions.add(iconPosition);

        // 添加图标信息（包含摇摆参数）
        lakeIcons.add({
          'row': iconPosition[0],
          'col': iconPosition[1],
          'icon': iconUnit,
          'swayOffset': _random.nextDouble() * 2 * pi, // 随机摇摆偏移
          'swaySpeed': 1.0 + _random.nextDouble() * 2.0, // 摇摆速度 1.0-3.0
          'swayAmplitude': 5 + _random.nextDouble() * 10, // 摇摆幅度 5-15度
        });
      }
    }
  } // 地形塌陷算法 - 让相似的地块聚集成更大的区域

  void _applyTerrainCollapseAlgorithm() {
    // 进行多轮塌陷，让地形更自然
    for (int iteration = 0; iteration < 4; iteration++) {
      _performCollapseIteration();
    }

    // 湖泊塌陷 - 让湖泊区域更自然
    _performLakeCollapse();
  }

  // 湖泊坍缩算法 - 优化版本：使用边界追踪和智能扩展
  void _performLakeCollapse() {
    print('开始湖泊坍缩...');

    int iteration = 0;
    int maxIterations = 10; // 增加最大迭代次数

    // 使用Set来追踪边界位置，提高性能
    Set<String> expansionCandidates = Set<String>();

    // 初始化：找到所有湖泊边界附近的浅色草地
    _initializeExpansionCandidates(expansionCandidates);

    while (expansionCandidates.isNotEmpty && iteration < maxIterations) {
      iteration++;
      print('湖泊坍缩第 $iteration 轮，待处理候选: ${expansionCandidates.length}');

      Set<String> newCandidates = Set<String>();
      int changedCells = 0;

      // 只处理边界候选位置，而不是整个网格
      for (String candidateKey in expansionCandidates) {
        List<int> pos = candidateKey.split(',').map(int.parse).toList();
        int row = pos[0];
        int col = pos[1];

        // 确保位置有效且是草地
        if (row < 0 ||
            row >= GRID_ROWS ||
            col < 0 ||
            col >= GRID_COLS ||
            terrainGrid[row][col] != 0 ||
            gameGrid[row][col] != 0) {
          continue;
        }

        List<List<int>> neighbors = _getNeighbors(row, col);
        int lakeNeighbors = 0;

        // 统计湖泊邻居
        for (var neighbor in neighbors) {
          if (terrainGrid[neighbor[0]][neighbor[1]] == 2) {
            lakeNeighbors++;
          }
        }

        bool shouldExpand = false;

        // 湖泊可以坍缩浅色草地(0)和标准草地(1)，禁止坍缩深色草地(2)
        if (grassColorGrid[row][col] <= 1) {
          if (lakeNeighbors >= 2) {
            // 中等扩展：浅色/标准草地且有2+湖泊邻居
            shouldExpand = true;
          } else if (lakeNeighbors >= 1) {
            // 弱扩展：浅色/标准草地且周围主要是浅色草地或湖泊
            if (_isInLightGrassCluster(row, col)) {
              shouldExpand = true;
            }
          }
        } else if (grassColorGrid[row][col] == 2) {
          // 特殊情况：深色草地被湖泊完全包围时也会坍缩
          if (lakeNeighbors >= 6) {
            // 如果深色草地周围有6个或更多湖泊邻居，认为被完全包围
            shouldExpand = true;
          }
        }

        if (!shouldExpand) {
          // 如果不满足扩展条件，继续下一个候选
          continue;
        }

        terrainGrid[row][col] = 2;
        changedCells++;

        // 添加新扩展位置的邻居作为下轮候选
        for (var neighbor in neighbors) {
          int nRow = neighbor[0];
          int nCol = neighbor[1];
          if (nRow >= 0 &&
              nRow < GRID_ROWS &&
              nCol >= 0 &&
              nCol < GRID_COLS &&
              terrainGrid[nRow][nCol] == 0 &&
              gameGrid[nRow][nCol] == 0) {
            newCandidates.add('$nRow,$nCol');
          }
        }
      }

      expansionCandidates = newCandidates;
      print('第 $iteration 轮湖泊坍缩完成，变化了 $changedCells 个格子');

      if (changedCells == 0) {
        print('没有更多变化，提前结束坍缩');
        break;
      }
    }

    print('湖泊坍缩结束，总共进行了 $iteration 轮');
  }

  // 初始化扩展候选位置
  void _initializeExpansionCandidates(Set<String> candidates) {
    for (int row = 0; row < GRID_ROWS; row++) {
      for (int col = 0; col < GRID_COLS; col++) {
        if (terrainGrid[row][col] == 2) {
          // 是湖泊
          // 添加湖泊周围的草地作为候选
          List<List<int>> neighbors = _getNeighbors(row, col);
          for (var neighbor in neighbors) {
            int nRow = neighbor[0];
            int nCol = neighbor[1];
            if (terrainGrid[nRow][nCol] == 0 && gameGrid[nRow][nCol] == 0) {
              candidates.add('$nRow,$nCol');
            }
          }
        }
      }
    }
  }

  // 检查是否在浅色草地聚集区域
  bool _isInLightGrassCluster(int row, int col) {
    List<List<int>> neighbors = _getNeighbors(row, col);
    int lightGrassOrLakeCount = 0;
    int totalValidNeighbors = 0;

    for (var neighbor in neighbors) {
      int nRow = neighbor[0];
      int nCol = neighbor[1];

      // 跳过道路格子
      if (gameGrid[nRow][nCol] != 0) continue;

      totalValidNeighbors++;

      if (terrainGrid[nRow][nCol] == 2 || // 湖泊
          (terrainGrid[nRow][nCol] == 0 && grassColorGrid[nRow][nCol] == 0)) {
        // 浅色草地
        lightGrassOrLakeCount++;
      }
    }

    // 如果周围60%以上是浅色草地或湖泊，则认为是在聚集区域
    return totalValidNeighbors > 0 &&
        (lightGrassOrLakeCount / totalValidNeighbors) >= 0.6;
  }

  // 执行一轮塌陷迭代
  void _performCollapseIteration() {
    List<List<int>> newGrassColorGrid = ListExtensions.create2D(
      GRID_ROWS,
      GRID_COLS,
      0,
    );

    // 复制当前草地颜色状态
    for (int row = 0; row < GRID_ROWS; row++) {
      for (int col = 0; col < GRID_COLS; col++) {
        newGrassColorGrid[row][col] = grassColorGrid[row][col];
      }
    }

    for (int row = 0; row < GRID_ROWS; row++) {
      for (int col = 0; col < GRID_COLS; col++) {
        // 跳过道路格子和湖泊格子
        if (gameGrid[row][col] == 1 || terrainGrid[row][col] == 2) continue;

        // 统计周围8个方向的颜色
        Map<int, int> colorCount = {};
        List<List<int>> neighbors = _getNeighbors(row, col);

        for (var neighbor in neighbors) {
          int neighborRow = neighbor[0];
          int neighborCol = neighbor[1];

          // 只考虑草地格子
          if (gameGrid[neighborRow][neighborCol] == 0 &&
              terrainGrid[neighborRow][neighborCol] == 0) {
            int color = grassColorGrid[neighborRow][neighborCol];
            colorCount[color] = (colorCount[color] ?? 0) + 1;
          }
        }

        // 如果当前格子周围有占主导地位的颜色，就向该颜色塌陷
        if (colorCount.isNotEmpty) {
          int dominantColor = colorCount.entries
              .reduce((a, b) => a.value > b.value ? a : b)
              .key;

          // 如果主导颜色的邻居数量超过阈值，就塌陷
          int dominantCount = colorCount[dominantColor]!;
          if (dominantCount >= 3) {
            // 阈值：至少3个相同颜色的邻居
            newGrassColorGrid[row][col] = dominantColor;
          }
        }
      }
    }

    grassColorGrid = newGrassColorGrid;
  }

  // 获取指定位置的8个邻居坐标
  List<List<int>> _getNeighbors(int row, int col) {
    List<List<int>> neighbors = [];
    List<List<int>> directions = [
      [-1, -1], [-1, 0], [-1, 1], // 上方三个
      [0, -1], [0, 1], // 左右两个
      [1, -1], [1, 0], [1, 1], // 下方三个
    ];

    for (var direction in directions) {
      int newRow = row + direction[0];
      int newCol = col + direction[1];

      // 检查边界
      if (newRow >= 0 &&
          newRow < GRID_ROWS &&
          newCol >= 0 &&
          newCol < GRID_COLS) {
        neighbors.add([newRow, newCol]);
      }
    }

    return neighbors;
  }

  @override
  Widget build(BuildContext context) {
    // 设置状态栏字体为白色
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.green, // 设置状态栏背景色
        statusBarIconBrightness: Brightness.light, // 状态栏图标为白色
      ),
    );

    // 如果游戏网格还没有初始化，显示加载界面
    if (gameGrid.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.green,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: GameGridPainter(
          gameGrid: gameGrid,
          terrainGrid: terrainGrid,
          grassColorGrid: grassColorGrid,
          carRow: carRow,
          carCol: carCol,
          carRotation: carRotation,
          currentCarUnit: currentCarUnit,
          lakeIcons: lakeIcons,
          animationTime: animationTime,
          grassColors: _grassColors,
          lakeColors: _lakeColors,
          gridRows: GRID_ROWS,
          gridCols: GRID_COLS,
          carSize: CAR_SIZE,
        ),
      ),
    );
  }
}

// Custom Painter 类用于高性能渲染游戏网格
class GameGridPainter extends CustomPainter {
  final List<List<int>> gameGrid;
  final List<List<int>> terrainGrid;
  final List<List<int>> grassColorGrid;
  final int carRow;
  final int carCol;
  final double carRotation;
  final String currentCarUnit;
  final List<Map<String, dynamic>> lakeIcons;
  final double animationTime;
  final List<Color> grassColors;
  final List<Color> lakeColors;
  final int gridRows;
  final int gridCols;
  final int carSize;

  GameGridPainter({
    required this.gameGrid,
    required this.terrainGrid,
    required this.grassColorGrid,
    required this.carRow,
    required this.carCol,
    required this.carRotation,
    required this.currentCarUnit,
    required this.lakeIcons,
    required this.animationTime,
    required this.grassColors,
    required this.lakeColors,
    required this.gridRows,
    required this.gridCols,
    required this.carSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 计算每个格子的大小
    double cellWidth = size.width / gridCols;
    double cellHeight = size.height / gridRows;

    // 创建画笔
    final Paint cellPaint = Paint()..style = PaintingStyle.fill;

    // 第一层：渲染草地和湖泊（背景层）
    for (int row = 0; row < gridRows; row++) {
      for (int col = 0; col < gridCols; col++) {
        // 跳过道路格子，稍后单独绘制
        if (gameGrid[row][col] == 1 || gameGrid[row][col] == 3) continue;

        // 计算格子位置
        double x = col * cellWidth;
        double y = row * cellHeight;
        Rect cellRect = Rect.fromLTWH(x, y, cellWidth, cellHeight);

        // 确定格子颜色
        Color cellColor;
        if (terrainGrid[row][col] == 2) {
          // 湖泊使用随机蓝色
          int lakeColorIndex = (row + col) % lakeColors.length;
          cellColor = lakeColors[lakeColorIndex];
        } else {
          // 草地使用预先分配的颜色
          cellColor = grassColors[grassColorGrid[row][col]];
        }

        // 绘制格子
        cellPaint.color = cellColor;
        canvas.drawRect(cellRect, cellPaint);
      }
    }

    // 第二层：绘制湖泊图标
    _drawLakeIcons(canvas, cellWidth, cellHeight);

    // 第三层：渲染道路（高优先级）
    for (int row = 0; row < gridRows; row++) {
      for (int col = 0; col < gridCols; col++) {
        // 只绘制道路格子
        if (gameGrid[row][col] != 1 && gameGrid[row][col] != 3) continue;

        // 计算格子位置
        double x = col * cellWidth;
        double y = row * cellHeight;
        Rect cellRect = Rect.fromLTWH(x, y, cellWidth, cellHeight);

        // 确定道路颜色
        Color cellColor;
        if (gameGrid[row][col] == 1) {
          // 普通道路
          cellColor = Color(0xFF424242); // 深灰色道路
        } else if (gameGrid[row][col] == 3) {
          // 中心线 - 黄色虚线效果（每隔2行显示）
          if (row % 4 == 0 || row % 4 == 1) {
            cellColor = Color(0xFFFFFFFF);
          } else {
            cellColor = Color(0xFF424242); // 道路底色
          }
        } else {
          cellColor = Colors.transparent; // 不应该到达这里
        }

        // 绘制道路格子
        cellPaint.color = cellColor;
        canvas.drawRect(cellRect, cellPaint);
      }
    }

    // 第四层：绘制车辆（最高优先级）
    _drawCar(canvas, cellWidth, cellHeight);
  }

  void _drawCar(Canvas canvas, double cellWidth, double cellHeight) {
    // 计算车辆位置和大小
    double carX = carCol * cellWidth;
    double carY = carRow * cellHeight;
    double carWidth = carSize * cellWidth;
    double carHeight = carSize * cellHeight;

    // 计算车辆中心点
    double carCenterX = carX + carWidth / 2;
    double carCenterY = carY + carHeight / 2;

    // 保存画布状态
    canvas.save();

    // 移动到车辆中心点并旋转
    canvas.translate(carCenterX, carCenterY);
    canvas.rotate(carRotation);
    canvas.translate(-carCenterX, -carCenterY);

    // 绘制车辆emoji（使用TextPainter）
    final textSpan = TextSpan(
      text: currentCarUnit, // 使用固定的车辆单位
      style: TextStyle(
        fontSize: (cellWidth + cellHeight) / 2 * 6, // 根据格子大小调整字体大小
        fontFamily: 'Apple Color Emoji', // 确保emoji正确显示
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // 将emoji绘制在车辆区域的中心
    double textX = carX + (carWidth - textPainter.width) / 2;
    double textY = carY + (carHeight - textPainter.height) / 2;

    textPainter.paint(canvas, Offset(textX, textY));

    // 恢复画布状态
    canvas.restore();
  }

  // 绘制湖泊图标
  void _drawLakeIcons(Canvas canvas, double cellWidth, double cellHeight) {
    for (var lakeIcon in lakeIcons) {
      int iconRow = lakeIcon['row'];
      int iconCol = lakeIcon['col'];
      String iconText = lakeIcon['icon'];
      double swayOffset = lakeIcon['swayOffset'] ?? 0.0;
      double swaySpeed = lakeIcon['swaySpeed'] ?? 1.0;
      double swayAmplitude = lakeIcon['swayAmplitude'] ?? 3.0;

      // 计算图标位置
      double iconX = iconCol * cellWidth;
      double iconY = iconRow * cellHeight;

      // 计算图标中心点
      double iconCenterX = iconX + cellWidth / 2;
      double iconCenterY = iconY + cellHeight / 2;

      // 计算摇摆角度
      double swayAngle =
          sin(animationTime * swaySpeed * 2 * pi + swayOffset) *
          swayAmplitude *
          pi /
          180;

      // 保存画布状态
      canvas.save();

      // 移动到图标中心点并旋转
      canvas.translate(iconCenterX, iconCenterY);
      canvas.rotate(swayAngle);
      canvas.translate(-iconCenterX, -iconCenterY);

      // 绘制图标emoji（使用TextPainter）
      final textSpan = TextSpan(
        text: iconText,
        style: TextStyle(
          fontSize: (cellWidth + cellHeight) / 2 * 5, // 比车辆稍小的字体
          fontFamily: 'Apple Color Emoji',
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      // 将emoji绘制在格子中心
      double textX = iconX + (cellWidth - textPainter.width) / 2;
      double textY = iconY + (cellHeight - textPainter.height) / 2;

      textPainter.paint(canvas, Offset(textX, textY));

      // 恢复画布状态
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant GameGridPainter oldDelegate) {
    // 只有在车辆位置改变、旋转角度改变、车辆图标改变、湖泊图标改变、动画时间改变或网格数据改变时才重绘
    return oldDelegate.carRow != carRow ||
        oldDelegate.carCol != carCol ||
        oldDelegate.carRotation != carRotation ||
        oldDelegate.currentCarUnit != currentCarUnit ||
        oldDelegate.lakeIcons != lakeIcons ||
        oldDelegate.animationTime != animationTime ||
        oldDelegate.gameGrid != gameGrid ||
        oldDelegate.terrainGrid != terrainGrid ||
        oldDelegate.grassColorGrid != grassColorGrid;
  }
}
