import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialDialog extends StatelessWidget {
  const TutorialDialog._({Key? key}) : super(key: key); // コンストラクタをプライベートに変更

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('チュートリアル'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('これはチュートリアルダイアログです。'),
            Text('必要な情報をここで提供してください。'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('閉じる'),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('tutorial_shown', true);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  // showメソッドを追加
  static Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const TutorialDialog._(); // プライベートコンストラクタを使用
      },
    );
  }
}
