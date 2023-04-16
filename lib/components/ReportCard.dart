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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 30),),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal:16, vertical: 8),
                alignment: Alignment.topLeft,
                // TODO: アイコンと進行中とかのステータスも取りたい感じはある
                child: Text('hoge'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal:16, vertical: 8),
                alignment: Alignment.topLeft,
                child: Text(widget.memo),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal:16, vertical: 8),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.archive),
                  label: Text('アーカイブ'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:16, vertical: 8),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.done),
                  label: Text('完了'),
                ),
              ),
            ],
          ),
        ],
      ),
      color: Colors.white, // Card自体の色
      margin: const EdgeInsets.all(30),
      elevation: 8, // 影の離れ具合
      shadowColor: Colors.black ,// 影の色
      shape: RoundedRectangleBorder( // 枠線を変更できる
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

