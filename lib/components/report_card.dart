import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String memo;
  final DateTime diaryDate;
  final VoidCallback onTap;

  const ReportCard({
    Key? key,
    required this.title,
    required this.memo,
    required this.diaryDate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: <Widget>[
            // ここにROWでカードのヘッダー等が入る
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal:16, vertical: 8),
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 5),
                    child: Text(title),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal:16, vertical: 8),
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, right: 5, bottom: 5, left: 5),
                    child: Text(memo),
                  ),
                ),
              ],
            ),
            // ここにROWでカードのアクションが入る
          ],
        ),
        color: Colors.white, // Card自体の色
        //margin: const EdgeInsets.all(30),
        //elevation: 8, // 影の離れ具合
        shadowColor: Colors.black ,// 影の色
      ),
    );
  }
}
