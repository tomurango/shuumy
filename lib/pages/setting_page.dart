import 'package:flutter/material.dart';
import 'package:shuumy/auth_notifier.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  Widget _buildLoginStatus(AuthNotifier authNotifier) {
    // final isAnonymous = authNotifier.user?.isAnonymous ?? true;
    bool? isAnonymous = authNotifier.user?.isAnonymous;
    return ListTile(
      title: Text('ユーザ情報'),
      // subtitle: Text(isAnonymous ? '匿名ユーザー' : 'ログイン済み'),
      subtitle: Text(isAnonymous == null ? '未ログイン' : (isAnonymous ? '匿名ユーザー' : 'ログイン済み')),
      onTap: () {
        // ユーザ情報管理画面へ
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);
    return ListView(
      children: [
        _buildLoginStatus(authNotifier),
        ListTile(
          title: Text('支払い管理'),
          onTap: () {
            // 支払い管理画面へ遷移
          },
        ),
        ListTile(
          title: Text('チュートリアル再確認'),
          onTap: () {
            // チュートリアル確認画面へ遷移
          },
        ),
        ListTile(
          title: Text('チャレンジのルール詳細'),
          onTap: () {
            // チュートリアル確認画面へ遷移
          },
        ),
        ListTile(
          title: Text('お問い合わせ'),
          onTap: () {
            // チュートリアル確認画面へ遷移
          },
        ),
      ],
    );
  }
}
