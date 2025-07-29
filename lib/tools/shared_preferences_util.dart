import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static late SharedPreferences _prefs;
  static bool _initialized = false;

  // 初始化方法，必须在使用前调用
  static Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  // 检查是否已初始化
  static bool get isInitialized => _initialized;

  // 存储字符串
  static Future<bool> setString(String key, String value) async {
    _checkInitialized();
    return await _prefs.setString(key, value);
  }

  // 获取字符串
  static String? getString(String key) {
    _checkInitialized();
    return _prefs.getString(key);
  }

  // 获取带默认值的字符串
  static String getStringOrDefault(String key, String defaultValue) {
    _checkInitialized();
    return _prefs.getString(key) ?? defaultValue;
  }

  // 存储整数
  static Future<bool> setInt(String key, int value) async {
    _checkInitialized();
    return await _prefs.setInt(key, value);
  }

  // 获取整数
  static int? getInt(String key) {
    _checkInitialized();
    return _prefs.getInt(key);
  }

  // 获取带默认值的整数
  static int getIntOrDefault(String key, int defaultValue) {
    _checkInitialized();
    return _prefs.getInt(key) ?? defaultValue;
  }

  // 存储布尔值
  static Future<bool> setBool(String key, bool value) async {
    _checkInitialized();
    return await _prefs.setBool(key, value);
  }

  // 获取布尔值
  static bool? getBool(String key) {
    _checkInitialized();
    return _prefs.getBool(key);
  }

  // 获取带默认值的布尔值
  static bool getBoolOrDefault(String key, bool defaultValue) {
    _checkInitialized();
    return _prefs.getBool(key) ?? defaultValue;
  }

  // 存储双精度浮点数
  static Future<bool> setDouble(String key, double value) async {
    _checkInitialized();
    return await _prefs.setDouble(key, value);
  }

  // 获取双精度浮点数
  static double? getDouble(String key) {
    _checkInitialized();
    return _prefs.getDouble(key);
  }

  // 获取带默认值的双精度浮点数
  static double getDoubleOrDefault(String key, double defaultValue) {
    _checkInitialized();
    return _prefs.getDouble(key) ?? defaultValue;
  }

  // 存储字符串列表
  static Future<bool> setStringList(String key, List<String> value) async {
    _checkInitialized();
    return await _prefs.setStringList(key, value);
  }

  // 获取字符串列表
  static List<String>? getStringList(String key) {
    _checkInitialized();
    return _prefs.getStringList(key);
  }

  // 获取带默认值的字符串列表
  static List<String> getStringListOrDefault(
    String key,
    List<String> defaultValue,
  ) {
    _checkInitialized();
    return _prefs.getStringList(key) ?? defaultValue;
  }

  // 检查键是否存在
  static bool containsKey(String key) {
    _checkInitialized();
    return _prefs.containsKey(key);
  }

  // 移除键值对
  static Future<bool> remove(String key) async {
    _checkInitialized();
    return await _prefs.remove(key);
  }

  // 清除所有数据
  static Future<bool> clear() async {
    _checkInitialized();
    return await _prefs.clear();
  }

  // 获取所有键
  static Set<String> getKeys() {
    _checkInitialized();
    return _prefs.getKeys();
  }

  // 检查初始化状态
  static void _checkInitialized() {
    if (!_initialized) {
      throw StateError('SharedPreferencesUtil 尚未初始化，请先调用 init() 方法');
    }
  }
}
