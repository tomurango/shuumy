import 'package:flutter/material.dart';
import 'package:shuumy/auth_notifier.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // googleログインボタン
        TextButton(
          child: Text('Googleログイン'),
          onPressed: () {
            // ここでAuthNotifierのインスタンスからsignInWithGoogleを呼び出します
            Provider.of<AuthNotifier>(context, listen: false).signInWithGoogle();
          },
        ),
        // メールログインボタン
        TextButton(
          child: Text('メールアドレスでログイン'),
          onPressed: () {
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
                  },
                )
            : SizedBox.shrink();  // ログインしていない、または匿名ユーザーの場合は何も表示しない
          },
        ),
      ],
    );
  }
}
