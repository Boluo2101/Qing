import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class ColorExtractor {
  // 从网络图片（支持缓存）中提取主色调（适配无ImageCache.get的版本）
  static Future<Color?> getMainColor(String imageUrl) async {
    try {
      // 1. 创建CachedNetworkImageProvider
      final provider = CachedNetworkImageProvider(imageUrl);

      // 2. 解析图片流，获取图片数据（无论是否有缓存，都会触发加载/读取缓存）
      final ImageStream stream = provider.resolve(const ImageConfiguration());

      // 3. 监听图片流，获取ImageInfo（包含图片数据）
      final Completer<ImageInfo> completer = Completer<ImageInfo>();
      late ImageStreamListener listener;

      listener = ImageStreamListener(
        (ImageInfo info, bool sync) {
          if (!completer.isCompleted) {
            completer.complete(info); // 完成回调，返回图片信息
          }
        },
        onError: (error, stackTrace) {
          if (!completer.isCompleted) {
            completer.completeError(error, stackTrace); // 错误处理
          }
        },
      );

      stream.addListener(listener);
      final ImageInfo imageInfo = await completer.future;
      stream.removeListener(listener); // 移除监听，避免内存泄漏

      // 4. 将ImageInfo转换为字节流（Uint8List）
      final ByteData? byteData = await imageInfo.image.toByteData(
        format: ImageByteFormat.png,
      );
      if (byteData == null) return null;
      final Uint8List imageBytes = byteData.buffer.asUint8List();

      // 5. 解码图片并提取主色调（逻辑不变）
      img.Image? image = img.decodeImage(imageBytes);
      if (image == null) return null;

      Map<int, int> colorCount = {};
      int maxCount = 0;
      int? mainColorValue;

      // 间隔采样像素（优化性能）
      for (int y = 0; y < image.height; y += 10) {
        for (int x = 0; x < image.width; x += 10) {
          int pixel = image.getPixel(x, y);
          // 转换为Flutter的ARGB格式（适配Color类）
          int argb =
              img.getAlpha(pixel) << 24 |
              img.getRed(pixel) << 16 |
              img.getGreen(pixel) << 8 |
              img.getBlue(pixel);

          colorCount[argb] = (colorCount[argb] ?? 0) + 1;
          if (colorCount[argb]! > maxCount) {
            maxCount = colorCount[argb]!;
            mainColorValue = argb;
          }
        }
      }

      return mainColorValue != null ? Color(mainColorValue) : null;
    } catch (e) {
      print("提取主色调失败：$e");
      return null;
    }
  }

  static Future<List<Color?>> getMainColors(String imageUrl, int count) async {
    List<Color?> colors = [];
    for (int i = 0; i < count; i++) {
      Color? color = await getMainColor(imageUrl);
      colors.add(color);
    }
    return colors;
  }
}
