import 'package:flutter/material.dart';
import 'package:shuumy/pages/daily_report_page.dart';
import 'package:shuumy/pages/challenge_page.dart';
import 'package:shuumy/pages/setting_page.dart';

// firebase 関連ライブラリ
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  // Firebaseなどの非同期処理を待機するための記述
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase 初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // アプリ開始
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MainPages({super.key, required this.title});

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
      ),
      body: pages[selectedIndex],
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: ,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      */
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
