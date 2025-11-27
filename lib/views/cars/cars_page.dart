// UI
import 'package:flutter/material.dart';

// Tools
import 'package:go_router/go_router.dart';

// Components
import './video_page.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final cars = [
    {
      'name': 'UFO',
      'description': '豪华高性能UFO',
      'key': 'ufo1',
      'bgPath': 'assets/images/cars/sea.png',
      'carPath': 'assets/images/cars/car1.png',
      'widthRatio': '0.9',
    },
    {
      'name': 'MOTORCYCLE',
      'description': '极速摩托车',
      'key': 'motorcycle1',
      'bgPath': 'assets/images/cars/sunset.png',
      'carPath': 'assets/images/cars/car2.png',
      'widthRatio': '1',
    },
    {
      'name': 'BYCICLE',
      'description': '环保自行车',
      'key': 'bycicle1',
      'bgPath': 'assets/images/cars/beach.mp4',
      'bgType': 'video',
      'carPath': 'assets/images/cars/car3.png',
      'widthRatio': '1',
    },
  ];

  String activeTabKey = 'ufo1';

  String getBgPathByKey(String activeTabKey) {
    for (var car in cars) {
      if (car['key'] == activeTabKey) {
        return car['bgPath']!;
      }
    }
    return 'assets/images/cars/sea.png';
  }

  Widget _buildTabBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...cars.map((car) {
          final isActive = car['key'] == activeTabKey;
          return GestureDetector(
            onTap: () {
              setState(() {
                activeTabKey = car['key']!;
              });
              print('切换到${car['name']}');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isActive ? Colors.white : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    car['name']!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),

        // Close button
        Expanded(child: Container()), // 占位，推到左侧
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: const Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildCarBox() {
    // 图片宽度撑满，高度1比1
    for (var car in cars) {
      if (car['key'] == activeTabKey) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            car['carPath']!,
            width:
                MediaQuery.of(context).size.width *
                (double.tryParse(car['widthRatio'] as String? ?? '1') ?? 1.0),
            height: MediaQuery.of(context).size.width,
            fit: BoxFit.contain,
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildInfosBox() {
    for (var car in cars) {
      if (car['key'] == activeTabKey) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'NXE ${car['name']}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                car['description']!,
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildButtonsBox() {
    // 预约试驾 立即订购
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                print('预约试驾按钮被点击');
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(width: 2, color: Colors.white),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                '预约试驾',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                print('立即订购按钮被点击');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                '立即订购',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBgByKey(String activeTabKey) {
    for (var car in cars) {
      if (car['key'] == activeTabKey) {
        if (car['bgType'] == 'video') {
          // 返回视频组件
          return VideoPage(videoUrl: getBgPathByKey(activeTabKey));
        } else {
          // 返回图片组件
          return Image.asset(
            getBgPathByKey(activeTabKey),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          );
        }
      }
    }
    // 默认返回图片组件
    return Image.asset(
      'assets/images/cars/sea.png',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. 全屏背景图/视频（底层）
          _buildBgByKey(activeTabKey),

          // 2. 前景内容（上层）
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabBar(),
                SizedBox(height: 20),
                _buildCarBox(),
                SizedBox(height: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildInfosBox(),
                      SizedBox(height: 30),
                      _buildButtonsBox(),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
