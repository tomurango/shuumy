import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {

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
            },
            child: Text(
              'チャレンジの内容を確認する',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
