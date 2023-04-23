import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('プロフィール編集'),
          onTap: () {
            // プロフィール編集画面へ遷移
          },
        ),
        ListTile(
          title: Text('支払い管理'),
          onTap: () {
            // 支払い管理画面へ遷移
          },
        ),
        ListTile(
          title: Text('チュートリアル確認'),
          onTap: () {
            // チュートリアル確認画面へ遷移
          },
        ),
      ],
    );
  }
}
