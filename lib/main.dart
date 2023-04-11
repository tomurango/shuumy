import 'package:flutter/material.dart';
import 'package:shuumy/pages/calender_page.dart';
import 'package:shuumy/pages/social_page.dart';
import 'package:shuumy/pages/setting_page.dart';

void main() {
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
  List<Widget> pages = [CalenderPage(), SocialPage(), SettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'カレンダー'),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), label: 'ソーシャル'),
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
