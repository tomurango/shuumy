import 'package:flutter/material.dart';
import 'package:shuumy/components/report_card.dart';
import 'package:shuumy/models/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shuumy/auth_notifier.dart';
import 'package:provider/provider.dart';

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

  /*Future<List<Report>> _fetchReports() async {
    if (_user == null) {
      return [];
    }
    // 過去７日間の日報を取得する
    final startAt = DateTime.now().subtract(Duration(days: 7));
    final endAt = DateTime.now().add(Duration(days: 1));
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user?.uid)
        .collection('reports')
        .where('userId', isEqualTo: _user!.uid)
        .where('diaryDate', isGreaterThanOrEqualTo: startAt)
        .where('diaryDate', isLessThanOrEqualTo: endAt)
        .orderBy('diaryDate', descending: true)
        .get();
    return querySnapshot.docs.map((doc) => Report.fromDocument(doc)).toList();
  }*/

  /*
  Future<List<Report>> _fetchReports() async {
    if (_user == null) {
      return [];
    }

    // デフォルトのリストを作成
    List<Report> reports = List.generate(7, (index) {
      return Report(
        id: '', 
        title: '未提出', 
        memo: '記載なし', 
        diaryDate: Timestamp.fromDate(DateTime.now().subtract(Duration(days: index)))
      );
    });
    // 過去７日間の日報を取得する
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, now.day - 6); // 7日前の日付を取得
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user?.uid)
        .collection('reports')
        .where('diaryDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .orderBy('diaryDate', descending: true)
        .get();

    querySnapshot.docs.forEach((doc) {
      Report report = Report.fromDocument(doc);
      DateTime reportDate = report.diaryDate.toDate();
      int daysAgo = DateTime.now().difference(reportDate).inDays;
      reports[daysAgo] = report; // 適切な位置にレポートを挿入
    });

    return reports;
  }
  */

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
          id: '', 
          title: '未提出', 
          memo: '記載なし', 
          diaryDate: Timestamp.fromDate(DateTime.now().subtract(Duration(days: index)))
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

  /*Widget _buildReportList() {
    return FutureBuilder<List<Report>>(
      future: _fetchReports(),
      builder: (BuildContext context, AsyncSnapshot<List<Report>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // エラーが発生した場合とデータが空の場合は日報のリストを空欄の状態で表示し、各種カードを配置する
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No reports found'));
        }

        List<Report> reports = snapshot.data!;
        // 日報のリストを過去７日間分表示する
        return Column(
          children: reports.map((report) => _buildReportCard(context, report)).toList(),
        );
      },
    );
  }*/

  /*
  Widget _buildReportList() {
    return FutureBuilder<List<Report>>(
      future: _fetchReports(),
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
  */

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
                  ? () => _showEditDialog(context, report.title, report.memo, date)
                  : () {},
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _isEditable(DateTime date) {
    DateTime today = DateTime.now();
    return date.day == today.day ||
        (date.day == today.subtract(Duration(days: 1)).day && today.hour < 12);
  }

  Color _getColor(DateTime date) {
    DateTime today = DateTime.now();
    if (date.day == today.day) {
        return Colors.teal;
    } else if (date.day == today.subtract(Duration(days: 1)).day && today.hour < 12) {
        return Colors.teal[200]!;
    } else {
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildReportList(),
      ),
    );
  }
}

