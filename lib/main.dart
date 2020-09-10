import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pomodoro',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _brakeTime = 300; // 5分
  int _workTime = 1500; // 25分
  int _current = 1500;
  bool _isWorkTime = false;
  bool _isStart = true;
  String _titleText = "ワークタイム";
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              // タイトル
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _titleText,
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),

              // 時間表示
              Container(
                child: Text(
                  formatTime(),
                  style: TextStyle(fontSize: 50),
                ),
              ),
              SizedBox(
                height: 50,
              ),

              // ボタン
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      child: Icon(Icons.play_arrow),
                      onPressed: !_isStart
                          ? null
                          : () {
                              _isStart = false;
                              startTimer();
                            },
                    ),
                    SizedBox(width: 50),
                    FloatingActionButton(
                      child: Icon(Icons.stop),
                      onPressed: _isStart
                          ? null
                          : () {
                              setState(() {
                                resetTimer();
                              });
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), onTimer);
  }

  void onTimer(Timer timer) {
    if (_current == 0) {
      setState(() {
        _isStart = true;
        _timer.cancel();
        if (_isWorkTime) {
          _current = _workTime;
          _isWorkTime = false;
          _titleText = "ワークタイム";
        } else {
          _current = _brakeTime;
          _isWorkTime = true;
          _titleText = "ブレイクタイム";
        }
      });
    } else {
      setState(() {
        _current--;
      });
    }
  }

  String formatTime() {
    final minutes = (_current / 60).floor().toString().padLeft(2, '0');
    final seconds = (_current % 60).floor().toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void resetTimer() {
    setState(() {
      _isStart = true;
      _timer.cancel();
      _current = _workTime;
      _isWorkTime = false;
      _titleText = "ワークタイム";
    });
  }
}
