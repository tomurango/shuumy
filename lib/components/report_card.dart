import 'package:flutter/material.dart';

class ReportCard extends StatefulWidget {

  final String title;
  final String memo;
  final DateTime diaryDate;
  
  const ReportCard({
    super.key,
    required this.title,
    required this.memo,
    required this.diaryDate,
  });

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: Text(widget.title),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal:16, vertical: 8),
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 0, right: 5, bottom: 5, left: 5),
                  child: Text(widget.memo),
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
      /*
      shape: RoundedRectangleBorder( // 枠線を変更できる
        borderRadius: BorderRadius.circular(10),
      ),
      */
    );
  }
}

