import 'package:flutter/material.dart';

class CalenderPage extends StatefulWidget {
  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                  child: Text('4/5'),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.orange,
                  child: Text('ここにやったことが表示される(Card)'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
