// UI
import 'package:flutter/material.dart';

// Components
import 'header_component.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 渐变背景色
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true, // 固定在顶部
              backgroundColor: Color.lerp(
                Colors.transparent,
                Colors.white,
                (_scrollOffset / 100).clamp(0.0, 1.0),
              ), // 根据滚动渐变背景色
              elevation: _scrollOffset > 50 ? 1 : 0, // 滚动时添加阴影
              automaticallyImplyLeading: false, // 不显示默认的返回按钮
              flexibleSpace: WordsHeader(_scrollOffset), // 使用自定义的Header组件
              expandedHeight: 0, // 根据header高度调整
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                // 这里可以添加更多内容
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    'Words Page Content',
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
