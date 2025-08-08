// UI
import '../../tools/custom_colors.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final String color;
  final String title;
  final String description;
  final double processNumber;
  final Widget icon;
  final Widget? titleBtn;
  final Function? onTap;

  const BookItem({
    super.key,
    required this.color,
    required this.title,
    required this.description,
    required this.processNumber,
    required this.icon,
    this.titleBtn,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null
          ? () {
              // 点击课程卡片，跳转到课程详情页
              print('点击了课程');
              // GoRouter.of(context).push('/course/${book['id']}');
              onTap!();
            }
          : null,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          children: [
            Icon(
              Icons.book_sharp,
              size: 90,
              color: CustomColors.getColorByStr(color),
            ),
            SizedBox(width: 0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (titleBtn != null) ...[titleBtn!],
                    ],
                  ),
                  SizedBox(height: 12),

                  // Progress bar
                  LinearProgressIndicator(
                    value: 0.5, // 假设进度为50%
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.getColorByStr(color).withOpacity(0.5),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Progress Text
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
