import 'package:flutter/material.dart';
import 'package:shuumy/components/challenge_start_button.dart';

class ChallengePage extends StatefulWidget {
  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  List<String> rules = [
    '・チャレンジを開始する',
    '・一週間の活動を行う',
    '・毎日活動を報告する',
    '・チャレンジを終了する',
    '・返金を受け取る',
  ];
  List<String> detailrules = [
    '・チャレンジの費用は700円です。この費用はあなたがチャレンジを開始する時に支払われます。',
    '・チャレンジの期間は一週間です。この一週間の間にあなたは指定された活動を行います。',
    '・毎日、あなたの活動を報告する必要があります。これはあなたのコミットメントを保つためのものです。',
    '・チャレンジが終了した後、あなたは返金を受け取ります。ただし、報告が欠けている日があると、その日数に応じて返金額が減少します。',
    '・具体的には、報告ができない日の数だけ返金額が100円減ります。そのため、毎日活動を報告することができれば、全額の700円が返ってきます。',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('チャレンジを開始すると進捗状況が表示されます。'),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // チャレンジ内容確認ボタンの処理をここに実装
              _showRuleDialog(context);
            },
            child: Text(
              'チャレンジの説明を見る',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          // チャレンジを始めるためのボタンをここに実装
          ChallengeStartButton(),
          /*TextButton(
            onPressed: () {
              // チャレンジを始めるボタンの処理をここに実装
            },
            child: Text(
              'チャレンジを始める',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),*/
        ],
      ),
    );
  }

  // ルール説明のダイアログ（フルスクリーン）を開くメソッド
  void _showRuleDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "チャレンジの説明",
              style: TextStyle(color: Colors.black), // AppBarのテキスト色を黒に設定
            ),
            backgroundColor: Colors.grey[200], // AppBarの背景色を暗い白（grey[200]）に設定
            leading: IconButton(
              icon: Icon(Icons.close),
              color: Colors.black, // IconButtonの色を黒に設定
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('チャレンジの流れ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var rule in rules) // rulesはあなたのルールが格納されたList
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(rule),
                      ),
                  ],
                ),
              ),
              ExpansionTile(
                title: Text('チャレンジの詳細'),
                children: <Widget>[
                  for (var rule in detailrules) // rulesはあなたのルールが格納されたList
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(rule, textAlign: TextAlign.left),
                    ),
                ], 
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ChallengeStartButton(),
              )
            ],
          ),
        );
      }
    );
  }
}
