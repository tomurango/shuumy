import 'package:flutter/material.dart';
import 'package:shuumy/pages/daily_report_page.dart';
import 'package:shuumy/pages/challenge_page.dart';
import 'package:shuumy/pages/login_page.dart';
import 'package:shuumy/pages/setting_page.dart';
import 'package:shuumy/components/tutorial_dialog.dart';
import 'package:shuumy/components/icon_menu.dart';

// firebase 関連ライブラリ
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// その他ライブラリ
// tutorial表示制御
import 'package:shared_preferences/shared_preferences.dart';
// user情報管理
import 'package:shuumy/auth_notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // authNotifierを作成
  final authNotifier = AuthNotifier();
  // ユーザーの初期化を待つ
  await authNotifier.initializeUser();
  runApp(
    ChangeNotifierProvider(
      create: (context) => authNotifier,
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuumy Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AuthChecker(),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authNotifier = Provider.of<AuthNotifier>(context);

    if (authNotifier.user == null) {
      // ログインページを表示
      return LoginPage();
    } else {
      // ログインしている場合はMyAppを起動
      return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();  // Loading indicator while waiting
          } else {
            final shown = snapshot.data!.getBool('tutorial_shown') ?? false;
            if (!shown) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                TutorialDialog.show(context); // ここで直接呼び出す
              });
              snapshot.data!.setBool('tutorial_shown', true); // チュートリアルが表示されたことを記録
            }
            return HomeScreen();  // あなたのアプリのホーム画面を表示
          }
        },
      );
    }
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPages(title: 'Flutter Demo Home Page');
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
          IconMenu(),
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
}
