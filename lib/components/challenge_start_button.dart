import 'package:flutter/material.dart';

class ChallengeStartButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
    );
  }
}
