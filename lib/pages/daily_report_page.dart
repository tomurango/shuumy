import 'package:flutter/material.dart';
import 'package:shuumy/components/report_card.dart';

class DailyReportPage extends StatefulWidget {
  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  
  Future<void> _showEditDialog(BuildContext context, String title, String memo, DateTime diaryDate) async {
    final titleController = TextEditingController(text: title);
    final memoController = TextEditingController(text: memo);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                TextField(
                  controller: memoController,
                  decoration: InputDecoration(hintText: 'Memo'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // データを保存する処理を追加
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                        onTap: () => _showEditDialog(context, 'Title for ${date.month}/${date.day}', 'Memo for ${date.month}/${date.day}', date),
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
