// Tools
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

// Components
import '../../components/header_bar.dart';

class CarPage extends StatefulWidget {
  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final List<Map<String, dynamic>> cars = [
    {
      'key': 'UFO',
      'src': 'assets/glb/3.glb',
      'name': 'UFO 2025 Pro Max Ultra Plus',
      'km': '1666',
      'percent': '80',
      'disableZoom': true,
    },
    {
      'key': 'CarBlack',
      'src': 'assets/glb/2.glb',
      'name': '岩破・霸王锤 Plus',
      'km': '1888',
      'percent': '50',
      'disableZoom': true,
    },
    {
      'key': 'Plane',
      'src': 'assets/glb/1.glb',
      'name': '隐身突防型战斗机',
      'km': '9999',
      'percent': '100',
      'disableZoom': true,
    },
    {
      'key': 'Motorcycle',
      'src': 'assets/glb/4.glb',
      'name': '🏍️摩托车',
      'km': '99',
      'percent': '100',
      'disableZoom': true,
    },
  ];
  String carName = 'UFO 2025 Pro Max Ultra Plus';
  String carUrl = 'assets/glb/3.glb';
  String selectedCarKey = 'UFO';
  String selectedCarKm = '1666';
  String selectedCarPercent = '80';
  bool disableZoom = true;

  String handleChangeNextCar() {
    print('切换车辆');
    int currentIndex = cars.indexWhere((car) => car['key'] == selectedCarKey);
    int nextIndex = (currentIndex + 1) % cars.length;
    setState(() {
      selectedCarKey = cars[nextIndex]['key']!;
      carName = cars[nextIndex]['name']!;
      carUrl = cars[nextIndex]['src']!;
      selectedCarKm = cars[nextIndex]['km']!;
      selectedCarPercent = cars[nextIndex]['percent']!;
      disableZoom = cars[nextIndex]['disableZoom'] ?? false;

      print('切换到车辆: $carName');
      print('车辆URL: $carUrl');
    });
    return cars[nextIndex]['key']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 使用灰色背景色
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: HeaderBar(
          bgColor: Colors.white,
          borderShow: false,
          title: '',
          leftWidth: 280,
          leftActions: [
            Padding(padding: const EdgeInsets.only(left: 12)),
            GestureDetector(
              onTap: () => handleChangeNextCar(),
              child: Text(
                carName,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
              ),
            ),
          ],
          rightActions: [
            IconButton(
              icon: const Icon(Icons.qr_code_scanner_sharp),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Row(
              children: [
                Text(
                  '已驻车 ｜ 更新于 3 分钟前',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  selectedCarKm,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'KM',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 50,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  padding: EdgeInsets.fromLTRB(5, 1, 5, 1), // 可选，添加内边距让文字不贴边
                  decoration: BoxDecoration(
                    color: Colors.white, // 背景色
                    border: Border.all(
                      color: Colors.grey, // 边框颜色
                      width: 1, // 边框宽度
                    ),
                    borderRadius: BorderRadius.circular(10), // 圆角半径
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.health_and_safety,
                            color: Colors.green,
                            size: 16,
                          ),
                        ),
                        TextSpan(
                          text: '99 ',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '健康分',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100, // 设置进度条宽度
                  child: LinearProgressIndicator(
                    value: double.parse(selectedCarPercent) / 100.0,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                SizedBox(height: 12), // 添加一些垂直间距
                Text(
                  '剩余电量 ${selectedCarPercent}%',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          Expanded(
            child: ModelViewer(
              key: Key(selectedCarKey), // 添加key属性
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              // src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
              // src: 'assets/gltf/car1/54431bf733b4450c83220a836cb6ad66.gltf',
              // src:
              //     'https://zcy-1251113349.cos.ap-chengdu.myqcloud.com/qing-app-server/files/gltf/car1/54431bf733b4450c83220a836cb6ad66.gltf',
              src: carUrl,
              alt: 'A 3D model of an astronaut',
              ar: true,
              autoRotate: true,
              cameraControls: true,
              disableZoom: disableZoom,
            ),
          ),
        ],
      ),
    );
  }
}
