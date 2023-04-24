import 'package:flutter/material.dart';
import 'package:shuumy/components/ReportCard.dart';

class DailyReportPage extends StatefulWidget {
  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                      child: Stack(
                        alignment: AlignmentDirectional.center, // 子要素を中央に配置する
                        children: <Widget>[
                          Container(
                            color: Colors.teal,
                            height: 56,
                            width: 56,
                          ),
                          Text('4/6'),
                        ]
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 0),
                      child: ReportCard(
                        title: 'hogetitle',
                        memo: 'hogehoge',
                        diaryDate: DateTime.now(),
                      )
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                      child: Stack(
                        alignment: AlignmentDirectional.center, // 子要素を中央に配置する
                        children: <Widget>[
                          Container(
                            color: Colors.teal[200],
                            height: 56,
                            width: 56,
                          ),
                          Text('4/5'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 0),
                      child: ReportCard(
                        title: 'hogetitle',
                        memo: 'hogehoge',
                        diaryDate: DateTime.now(),
                      )
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                      child: Stack(
                        alignment: AlignmentDirectional.center, // 子要素を中央に配置する
                        children: <Widget>[
                          Text('4/4'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 0),
                      child: ReportCard(
                        title: 'hogetitle',
                        memo: 'hogehoge',
                        diaryDate: DateTime.now(),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
