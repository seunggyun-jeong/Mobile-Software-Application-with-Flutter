// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:good_habit/HomeView.dart';
import 'package:hive/hive.dart';
import 'package:good_habit/type.dart';

class SetBreakMode extends StatefulWidget {
  const SetBreakMode({super.key});

  @override
  State<SetBreakMode> createState() => _SetBreakModeState();
}

class _SetBreakModeState extends State<SetBreakMode> {
  late DateTime setTime;
  late DateTime nowTime;
  final _myBox = Hive.box('myBox');

  int hour = 0;
  int min = 0;
  int sec = 0;

  @override
  void initState() {
    super.initState();

    setTime = _myBox.get('breakModeSetTime');
    nowTime = DateTime.now();

    Timer.periodic(const Duration(seconds: 1), (timer) => startTimer());
  }

  // 타이머 동작 메서드
  void startTimer() {
    setState(() {
      nowTime = DateTime.now();
      var timeDiffrence = nowTime.difference(setTime).inSeconds;
      hour = timeDiffrence ~/ 3600;
      min = (timeDiffrence % 3600) ~/ 60;
      sec = ((timeDiffrence % 3600) % 60);
    });
  }

  void _reinitialize() {
    _myBox.delete('breakModeSetTime');
    _myBox.delete('modeType');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => const HomeWidget(),
      ),
      (Route route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: TextButton(
              onPressed: _reinitialize,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text("초기화")),
          title: const Text("금연 모드 설정"),
          backgroundColor: Colors.pink,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 80,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('금연한지 ...'),
                    Text(
                        '${'$hour'.padLeft(2, '0')}:${'$min'.padLeft(2, '0')}:${'$sec'.padLeft(2, '0')}',
                        style: const TextStyle(fontFamily: 'MonoSpace')),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
