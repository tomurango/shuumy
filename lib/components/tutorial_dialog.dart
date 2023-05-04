import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialDialog extends StatelessWidget {
  const TutorialDialog._({Key? key}) : super(key: key); // コンストラクタをプライベートに変更

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'shuumyの使い方',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context), // ダイアログを閉じる
          ),
        ),
        body: TutorialContents(),
      ),
    );
  }

  // showメソッドを追加
  static Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const TutorialDialog._(); // プライベートコンストラクタを使用
      },
    );
  }
}

class TutorialContents extends StatefulWidget {
  @override
  _TutorialContentsState createState() => _TutorialContentsState();
}

class _TutorialContentsState extends State<TutorialContents> {
  int _currentPage = 0;
  List<Map<String, dynamic>> pageContents = [
    {
      //'image': AssetImage('assets/images/image1.png'),
      'title': '1.日報を作ろう',
      'text': 'その日自分がやったことを記録・報告しよう。チャレンジ機能を使わなくても日報の作成はできるぞ！',
    },
    {
      //'image': AssetImage('assets/images/image2.png'),
      'title': '2.チャレンジを始めよう',
      'text': 'チャレンジは1000円で1週間に挑戦できるぞ。あなたの報告に応じてお金が返ってくる!',
    },
    {
      //'image': AssetImage('assets/images/image3.png'),
      'title': '3.さあ！始めよう！',
      'text': 'Shuumyを活用して自分の行動を自由自在に!チャレンジのルールは設定画面から確認できるぞ。',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemCount: pageContents.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  //Image(image: pageContents[index]['image']),
                  SizedBox(height: 16),
                  Text(
                    pageContents[index]['title'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    pageContents[index]['text'],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(3, (int index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 10,
                width: _currentPage == index ? 20 : 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _currentPage == index ? Colors.black : Colors.grey,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}