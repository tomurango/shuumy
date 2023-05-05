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

  Future<List<Report>> _fetchReports() async {
    if (_user == null) {
      return [];
    }
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user?.uid)
        .collection('reports')
        .get();
    return querySnapshot.docs.map((doc) => Report.fromDocument(doc)).toList();
  }

  Widget _buildReportList() {
    return FutureBuilder<List<Report>>(
      future: _fetchReports(),
      builder: (BuildContext context, AsyncSnapshot<List<Report>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No reports found'));
        }

        List<Report> reports = snapshot.data!;
        return Column(
          children: reports.map((report) => _buildReportCard(context, report)).toList(),
        );
      },
    );
  }


  Widget _buildReportCard(BuildContext context, Report report) {
    DateTime date = report.diaryDate.toDate();
    bool isEditable = _isEditable(date);
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
                          color: Colors.teal,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildReportList(),
      ),
    );
  }
}

