import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final int currentIndex;
  final String style; // default / tag
  final bool getStyleIsTag;
  final List tabsList;
  final Function(int) onTap;

  Tabs({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.style = 'default',
    required this.tabsList,
  }) : getStyleIsTag = style == 'tag';

  // Tag 样式的 InkWell
  Widget _buildTagStyleInkWell(int idx, Map item, bool isSelected) {
    return InkWell(
      // 禁用水波纹效果
      splashFactory: NoSplash.splashFactory,
      onTap: () => onTap(idx),
      child: Container(
        margin: EdgeInsets.fromLTRB(idx >= 1 ? 0 : 16, 16, 16, 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: isSelected ? Color(0xFF144ee6) : Color(0xFFF6F6F6),
        ),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          item['label'],
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? Colors.white : Colors.grey[900],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Default 样式的 InkWell
  Widget _buildDefaultStyleInkWell(int idx, Map item, bool isSelected) {
    return InkWell(
      onTap: () => onTap(idx),
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Color(0xFF144ee6) : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: Text(
          item['label'],
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Color(0xFF144ee6) : Colors.grey[900],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 可滚动的标签栏
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: getStyleIsTag
                  ? BorderSide.none
                  : BorderSide(
                      color: Colors.grey[200]!, // 底部灰色分隔线
                      width: 1,
                    ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabsList.asMap().entries.map((entry) {
                final int idx = entry.key;
                final item = entry.value;
                final isSelected = currentIndex == idx;

                final Widget inkWell = getStyleIsTag
                    ? _buildTagStyleInkWell(idx, item, isSelected)
                    : _buildDefaultStyleInkWell(idx, item, isSelected);

                return inkWell;
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
