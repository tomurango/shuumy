import 'package:flutter/material.dart';
import 'package:shuumy/components/ReportCard.dart';

class CalenderPage extends StatefulWidget {
  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, right: 5, bottom: 10, left: 10),
                    child: Text('4/5'),
                  ),
                  color: Colors.blue,
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, right: 5, bottom: 10, left: 10),
                    child: ReportCard(
                      title: 'hogetitle',
                      memo: 'hogehoge',
                      diaryDate: DateTime.now(),
                    )
                  ),
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
