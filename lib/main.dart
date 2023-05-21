import 'package:flutter/material.dart';
import 'package:shuumy/pages/daily_report_page.dart';
import 'package:shuumy/pages/challenge_page.dart';
import 'package:shuumy/pages/setting_page.dart';
import 'package:shuumy/components/tutorial_dialog.dart';

// firebase 関連ライブラリ
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
*/

// その他ライブラリ
// tutorial表示制御
import 'package:shared_preferences/shared_preferences.dart';
// user情報管理
import 'package:shuumy/auth_notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  // Firebaseなどの非同期処理を待機するための記述
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase 初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // アプリ開始
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuumy Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MainPages(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPages extends StatefulWidget {
  const MainPages({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  // 選択中フッターメニューのインデックスを一時保存する用変数
  int selectedIndex = 0;

  // 切り替える画面のリスト
  List<Widget> pages = [DailyReportPage(), ChallengePage(), SettingPage()];

  // 各ページのタイトルを格納するリスト
  List<String> pageTitles = ['日報', 'チャレンジ', '設定'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[selectedIndex]),
        actions: [
          Consumer<AuthNotifier>(
            builder: (context, authNotifier, _) {
              final user = authNotifier.user;
              if (user == null || user.isAnonymous) {
                // 匿名ログイン時のアイコン
                return TextButton.icon(
                  onPressed: () => _showLoginDialog(context),
                  icon: Icon(Icons.person),
                  label: Text('ログイン'),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                );
              }  else if (user.photoURL != null) {
                // Googleログイン時のアイコン
                return IconButton(
                  icon: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                  onPressed: () => _showLoginDialog(context),
                );
              } else {
                // メールアドレスログイン時のアイコン
                return IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => _showLoginDialog(context),
                );
              }
            },
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: '日報'),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: 'チャレンジ'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
        // 現在選択されているフッターメニューのインデックス
        currentIndex: selectedIndex,
        // フッター領域の影
        elevation: 0,
        // フッターメニュータップ時の処理
        onTap: (int index) {
          selectedIndex = index;
          setState(() {});
        },
        // 選択中フッターメニューの色
        fixedColor: Colors.red,
      ),
    );
  }

  // tutorial表示可否確認用
  @override
  void initState() {
    super.initState();
    _checkTutorialShown();
  }

  /*
  Future<void> _checkTutorialShown() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool('tutorial_shown') ?? false;

    if (!shown) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        TutorialDialog.show(context); // ここで直接呼び出す
      });
    }
  }
  */

  Future<void> _checkTutorialShown() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool('tutorial_shown') ?? false;

    if (!shown) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        TutorialDialog.show(context); // ここで直接呼び出す
      });
      await prefs.setBool('tutorial_shown', true); // チュートリアルが表示されたことを記録
    }
  }


  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ログイン方法を選択'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: Text('Googleログイン'),
              /*onPressed: () {
                Navigator.pop(context);
                _signInWithGoogle();
              },*/
              onPressed: () {
                // ここでAuthNotifierのインスタンスからsignInWithGoogleを呼び出します
                Provider.of<AuthNotifier>(context, listen: false)
                    .signInWithGoogle();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('メールアドレスでログイン'),
              onPressed: () {
                Navigator.pop(context);
                // メールアドレスでログインする処理を実装
              },
            ),
          ],
        ),
      ),
    );
  }

  /*
  Future<void> _signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }
  */
}

/*
// ログインについて
class LoginStatus extends StatefulWidget {
  @override
  _LoginStatusState createState() => _LoginStatusState();
}

class _LoginStatusState extends State<LoginStatus> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final user = snapshot.data;

        if (user == null) {
          return TextButton(
            onPressed: () => _showLoginDialog(context),
            child: Text('ログイン'),
          );
        } else {
          return Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL ?? ''),
              ),
              SizedBox(width: 8),
              TextButton(
                onPressed: () => auth.signOut(),
                child: Text('ログアウト'),
              ),
            ],
          );
        }
      },
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ログイン方法を選択'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text('Googleでログイン'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: メールアドレスでのログイン処理を実装
              },
              child: Text('メールアドレスでログイン'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }
}*/
