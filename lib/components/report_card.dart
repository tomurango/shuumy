/*
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
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatefulWidget {
  final String title;
  final String memo;
  final DateTime diaryDate;

  ReportCard({required this.title, required this.memo, required this.diaryDate});

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _memoController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title;
    _memoController.text = widget.memo;
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveData() async {
    CollectionReference reports =
        FirebaseFirestore.instance.collection('reports');
    await reports.doc(widget.diaryDate.toString()).set({
      'title': _titleController.text,
      'memo': _memoController.text,
      'date': widget.diaryDate,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_isEditing) {
          _saveData();
        }
        _toggleEditing();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isEditing
                  ? TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    )
                  : Text(
                      widget.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
              SizedBox(height: 8),
              _isEditing
                  ? TextField(
                      controller: _memoController,
                      decoration: InputDecoration(
                        labelText: 'Memo',
                        border: OutlineInputBorder(),
                      ),
                    )
                  : Text(widget.memo),
            ],
          ),
        ),
      ),
    );
  }
}

