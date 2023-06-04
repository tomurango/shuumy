import 'package:flutter/material.dart';
//import 'package:shuumy/auth_notifier.dart';
//import 'package:provider/provider.dart';
import 'package:shuumy/components/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ログイン前に戻るボタンを非表示にする
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: LoginWidget(),  // LoginWidgetを利用する
      ),
    );
  }
}
