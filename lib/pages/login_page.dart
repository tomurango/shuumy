import 'package:flutter/material.dart';
//import 'package:shuumy/auth_notifier.dart';
//import 'package:provider/provider.dart';
import 'package:shuumy/components/login_widget.dart';

/*
class LoginPage extends StatelessWidget {
  const LoginPage._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          // child: Text('ログイン画面'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // googleログインボタン
              TextButton(
                child: Text('Googleログイン'),
                onPressed: () {
                  // ここでAuthNotifierのインスタンスからsignInWithGoogleを呼び出します
                  Provider.of<AuthNotifier>(context, listen: false).signInWithGoogle();
                  Navigator.pop(context);
                },
              ),
              // メールログインボタン
              TextButton(
                child: Text('メールアドレスでログイン'),
                onPressed: () {
                  Navigator.pop(context);
                  // メールアドレスでログインする処理を実装
                },
              ),
              // ログアウトボタン
              Consumer<AuthNotifier>(
                builder: (context, auth, child) {
                  return auth.user != null && !auth.user!.isAnonymous
                    ? TextButton(
                      child: Text('ログアウト'),
                      onPressed: () {
                          auth.signOut();
                          Navigator.pop(context);
                        },
                      )
                  : SizedBox.shrink();  // ログインしていない、または匿名ユーザーの場合は何も表示しない
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoginPage._();
      },
    );
  }
}
*/

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
