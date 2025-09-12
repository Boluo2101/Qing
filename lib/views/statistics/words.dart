import 'package:flutter/material.dart';
import 'dart:math' as math;

// 修复排序逻辑：实现“中间最大、向两侧对称减小”
List<Map<String, dynamic>> formatWords(List<Map<String, dynamic>> words) {
  final List<Map<String, dynamic>> formattedWords = [];

  // 1. 过滤无效数据（确保有name和value），并计算字体大小
  for (var word in words) {
    if (word.containsKey('name') &&
        word.containsKey('value') &&
        word['value'] > 0) {
      formattedWords.add(word);
    }
  }

  // 2. 计算最大值（避免除以0）
  final int maxValue = formattedWords.fold(
    1, // 初始值设为1，防止所有value为0时除以0
    (max, word) => word['value'] > max ? word['value'] : max,
  );

  // 3. 为每个词语计算字体大小（10-40之间）
  final List<Map<String, dynamic>> sizedWords = formattedWords.map((word) {
    final num fontSize = 10 + (word['value'] / maxValue) * 12;
    return {
      'name': word['name'],
      'value': word['value'],
      'fontSize': fontSize.clamp(10, 40), // 强制限制在10-40，避免异常大小
      'opacity': 0.5 + (word['value'] / maxValue) * 0.5, // 透明度0.5-1.0
    };
  }).toList();

  // 4. 第一步排序：按字体大小降序（最大的在最前）
  sizedWords.sort((a, b) => b['fontSize'].compareTo(a['fontSize']));

  // 5. 只保留前20个词
  final int maxWords = math.min(20, sizedWords.length);
  sizedWords.removeRange(maxWords, sizedWords.length);

  // 6. 第二步排序：交替插入开头和结尾，实现“中间大、两边小”
  final List<Map<String, dynamic>> finalWords = [];
  bool insertToStart = false; // 标记下一个词插入到开头还是结尾

  for (var word in sizedWords) {
    if (insertToStart) {
      finalWords.insert(0, word); // 第2大的插开头，第4大的插开头...
    } else {
      finalWords.add(word); // 第1大的插结尾（即初始第一个），第3大的插结尾...
    }
    insertToStart = !insertToStart; // 切换插入位置
  }

  return finalWords;
}

class WordsCloud extends StatelessWidget {
  // 词云数据
  static const List<Map<String, dynamic>> words = [
    {'name': '三体', 'value': 1000},
    {'name': '阿西莫夫', 'value': 800},
    {'name': '刘慈欣', 'value': 800},
    {'name': '科幻', 'value': 600},
    {'name': '银河系搭车客指南', 'value': 700},
    {'name': '人类简史', 'value': 200},
    {'name': '黑客与画家', 'value': 100},
    {'name': '浪潮之巅', 'value': 500},
    {'name': '自私的基因', 'value': 300},
    {'name': '编码', 'value': 10},
    {'name': '设计模式', 'value': 25},
    {'name': '算法导论', 'value': 30},
    {'name': '计算机程序的构造和解释', 'value': 450},
    {'name': '深入理解计算机系统', 'value': 550},
    {'name': '操作系统概念', 'value': 650},
    {'name': '编译原理', 'value': 750},
    {'name': '计算机网络', 'value': 850},
    {'name': '数据库系统概念', 'value': 50},
  ];

  static const Color color = Color(0xFF144ee6);

  const WordsCloud({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Wrap(
          spacing: 12.0,
          // runSpacing: 12.0,
          alignment: WrapAlignment.center,
          // 确保每行文字垂直居中对齐
          crossAxisAlignment: WrapCrossAlignment.center,
          children: formatWords(words).map((word) {
            return Text(
              word['name'],
              style: TextStyle(
                color: color.withOpacity(word['opacity']),
                fontWeight: FontWeight.bold,
                fontSize: word['fontSize'],
              ),
              overflow: TextOverflow.visible,
              // 文本基线对齐，确保不同大小文字在视觉上垂直对齐
            );
          }).toList(),
        ),
      ),
    );
  }
}
