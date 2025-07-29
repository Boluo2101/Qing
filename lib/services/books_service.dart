import 'dart:convert';
import 'package:http/http.dart' as http;
import '../configs/configs.dart';

// 用户 API 服务类 - 类似于 Vue 中的 API 模块
class BooksService {
  // API 基础地址 - 使用 JSONPlaceholder 作为测试 API
  static const String baseUrl = CONFIGs.API_HOST;

  // 请求头配置
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // 获取指定课程的详情 getBookDetailsById
  static Future<List<Map<String, dynamic>>> getBookDetailsById(
    String bookId,
  ) async {
    final url = Uri.parse('$baseUrl/mocks/books/$bookId.json');
    print('请求 URL: $url');

    final response = await http.get(url, headers: headers);
    print('响应状态码: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('响应数据: ${response.body}');
      final decodedData = json.decode(response.body);

      // 如果返回的是List，直接返回
      if (decodedData is List) {
        return decodedData.cast<Map<String, dynamic>>();
      }
    } else {
      throw Exception('Failed to load book details');
    }
    throw Exception('Invalid response format: not a List');
  }
}
