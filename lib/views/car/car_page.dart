import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class CarPage extends StatefulWidget {
  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  late Object mesh;

  @override
  void initState() {
    super.initState();
    // 加载 OBJ 文件
    mesh = Object(fileName: "assets/obj/cars/Low_Poly_City_Cars.obj");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("3D Model Viewer")),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Cube(
              onSceneCreated: (Scene scene) {
                // 添加模型到场景
                scene.world.add(mesh);

                // 设置相机位置和缩放
                scene.camera.position.setValues(0, 5, 10);
                scene.camera.target.setValues(0, 0, 0);
                scene.camera.zoom = 8;

                // 设置光照位置
                scene.light.position.setValues(-10, 10, 10);
              },
            ),
          ),
        ),
      ),
    );
  }
}
