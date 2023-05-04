import 'package:flutter/material.dart';
import 'package:shuumy/components/report_card.dart';

class DailyReportPage extends StatefulWidget {
  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<DateTime> pastDates = List.generate(
      7,
      (index) => today.subtract(Duration(days: index)),
    );

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: pastDates.map((date) {
            bool isEditable = date.day == today.day ||
                (date.day == today.subtract(Duration(days: 1)).day &&
                    today.hour < 12);

            return Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          isEditable
                              ? Container(
                                  color: date.day == today.day
                                      ? Colors.teal
                                      : Colors.teal[200],
                                  height: 56,
                                  width: 56,
                                )
                              : SizedBox(),
                          Text('${date.month}/${date.day}'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 0),
                      child: ReportCard(
                        title: 'Title for ${date.month}/${date.day}',
                        memo: 'Memo for ${date.month}/${date.day}',
                        diaryDate: date,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
