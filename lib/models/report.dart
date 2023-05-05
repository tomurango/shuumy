import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Report {
  final String id;
  final String title;
  final String memo;
  final Timestamp diaryDate;

  Report({
    required this.id,
    required this.title,
    required this.memo,
    required this.diaryDate,
  });

  factory Report.fromDocument(DocumentSnapshot doc) {
    return Report(
      id: doc.id,
      title: doc['title'],
      memo: doc['memo'],
      diaryDate: doc['diaryDate'],
    );
  }
}
