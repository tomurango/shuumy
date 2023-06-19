import 'package:flutter/material.dart';
import 'package:shuumy/components/report_card.dart';
import 'package:shuumy/models/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shuumy/auth_notifier.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DailyReportPage extends StatefulWidget {
  @override
  State<DailyReportPage> createState() => _DailyReportPageState();
}

class _DailyReportPageState extends State<DailyReportPage> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  List<Report>? reports;

  @override
  void initState() {
    super.initState();
    final authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    _user = authNotifier.user;
  }

  Future<void> _showEditDialog(BuildContext context, String title, String memo, DateTime diaryDate, String reportId) async {
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
              onPressed: () async {
                try {
                  // データを保存する処理を追加
                  //String docId = DateFormat('yyyyMMdd').format(diaryDate);
                  // firestoreに保存する
                  // ドキュメントIDは年月日の情報を文字列にしたものとする
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_user?.uid)
                      .collection('reports')
                      .doc(reportId)
                      .set({
                        'title': titleController.text,
                        'memo': memoController.text,
                        'diaryDate': Timestamp.fromDate(DateTime.now()),
                      });
                  Navigator.of(context).pop();
                } catch (e) {
                  // print the exception to the console or show it in the UI
                  print("Failed to save the data: $e");
                  // Optionally, you could add a dialog here to inform the user about the error
                }
              },
            ),
          ],
        );
      },
    );
  }

  Stream<List<Report>> _fetchReports() {
    if (_user == null) {
      return Stream.value([]);
    }

    // 過去７日間の日報を取得する
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, now.day - 6); // 7日前の日付を取得
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_user?.uid)
        .collection('reports')
        .where('diaryDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .orderBy('diaryDate', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<Report> reports = List.generate(7, (index) {
        return Report(
          id: DateFormat('yyyyMMdd').format(DateTime.now().subtract(Duration(days: index))), 
          title: '未提出', 
          memo: '記載なし', 
          diaryDate: Timestamp.fromDate(DateTime.now().subtract(Duration(days: index))),
        );
      });

      querySnapshot.docs.forEach((doc) {
        Report report = Report.fromDocument(doc);
        DateTime reportDate = report.diaryDate.toDate();
        int daysAgo = DateTime.now().difference(reportDate).inDays;
        reports[daysAgo] = report; // 適切な位置にレポートを挿入
      });

      return reports;
    });
  }

  Widget _buildReportList() {
    return StreamBuilder<List<Report>>(
      stream: _fetchReports(),  // use stream here
      builder: (BuildContext context, AsyncSnapshot<List<Report>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // データが空の場合は日報のリストを空欄の状態で表示し、各種カードを配置する
        // エラーが発生した場合はエラーを表示する
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Report> reports = snapshot.data!;
        // 日報のリストを過去７日間分表示する
        return Column(
          children: reports.map((report) => _buildReportCard(context, report)).toList(),
        );
      },
    );
  }

  Widget _buildReportCard(BuildContext context, Report report) {
    DateTime date = report.diaryDate.toDate();
    String reportId = report.id;
    bool isEditable = _isEditable(date);
    Color color = _getColor(date);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 5, right: 0, bottom: 0, left: 5),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  isEditable
                      ? Container(
                          color: color,
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
              padding: EdgeInsets.only(top: 5, right: 5, bottom: 0, left: 0),
              child: ReportCard(
                title: report.title,
                memo: report.memo,
                diaryDate: date,
                onTap: isEditable
                  ? () => _showEditDialog(context, report.title, report.memo, date, reportId)
                  : () {},
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 日報が編集可能かどうかを判定する
  bool _isEditable(DateTime date) {
    // 当日中のみ編集可能
    DateTime today = DateTime.now();
    return date.day == today.day;
  }

  // 日報が編集可能な場合は色をつける
  Color _getColor(DateTime date) {
    DateTime today = DateTime.now();
    if (date.day == today.day) {
      return Colors.teal;
    } else {
      return Colors.transparent;
    }
  }

  // 日報の作成日時を年月日のみにする
  /*
  DateTime _toDateTime(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateTime(date.year, date.month, date.day);
  }
  */

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildReportList(),
      ),
    );
  }
}

