import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CutDownView extends StatefulWidget {
  const CutDownView({super.key});

  @override
  State<CutDownView> createState() => _CutDownViewState();
}

class _CutDownViewState extends State<CutDownView> {
  // 통계 관련 변수
  int count = 0;
  int setCount = 10;
  int money = 0;
  int nicotine = 0;
  int tar = 0;

  // 습관 분석 관련 변수
  Duration setTime = const Duration(hours: 1);
  late DateTime nowTime;
  late DateTime finishTime;
  int leftTime = 0;

  int hour = 0;
  int min = 0;
  int sec = 0;

  void setTimer() {
    setState(() {
      nowTime = DateTime.now();
      finishTime = nowTime.add(setTime);
      leftTime = finishTime.difference(nowTime).inSeconds;
      print("남은시간 =---->$leftTime");
      Timer.periodic(const Duration(seconds: 1), (timer) => startTimer());
    });
  }

  void startTimer() {
    setState(() {
      leftTime--;
      hour = leftTime ~/ 3600;
      min = (leftTime % 3600) ~/ 60;
      sec = ((leftTime % 3600) % 60);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    nowTime = DateTime.now();
  }

  void incrementCounter() {
    setState(() {
      if (setCount > 0 && leftTime == 0) {
        // 한 번 터치 시 할당량 한 개비 감소
        setCount--;
        // 한 번 터치 시 한 개비 증가
        count++;
        // 담배 한 개비 당 225원
        money = count * 225;
        // 담배 한 개비 당 약 1mg 니코틴 흡입
        nicotine = count * 1;
        // 담배 한 개비 당 약 10mg 타르 흡입
        tar = count * 10;
        setTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("절연모드"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: statisticsSection(),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration:
                              customBoxStyle(10, 10, 0, 0, Colors.amber),
                          child: const Text(
                            "습관 분석",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.center,
                          decoration: customBoxStyle(0, 0, 10, 10, Colors.cyan),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "남은 시간",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 80,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                        '${'$hour'.padLeft(2, '0')}:${'$min'.padLeft(2, '0')}:${'$sec'.padLeft(2, '0')}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'MonoSpace')),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }

  Column statisticsSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: customBoxStyle(10, 10, 0, 0, Colors.amber),
          child: const Text(
            "통계",
            style: TextStyle(fontSize: 40),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: customBoxStyle(0, 0, 10, 10, Colors.cyan),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            statisticsRow("오늘 할당량", setCount, "개"),
            statisticsRow("오늘 피운 담배", count, "개"),
            statisticsRow("오늘 사용한 돈", money, "원"),
            statisticsRow("누적된 니코틴", nicotine, "mg"),
            statisticsRow("누적된 타르", tar, "mg")
          ]),
        ),
      ],
    );
  }

  Row statisticsRow(String title, int value, String unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text(
            title + " : ",
          ),
        ),
        Container(
          width: 150,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value.toString() + unit,
          ),
        )
      ],
    );
  }

  BoxDecoration customBoxStyle(
      double topL, double topR, double botL, double botR, Color color) {
    return BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topL),
            topRight: Radius.circular(topR),
            bottomLeft: Radius.circular(botL),
            bottomRight: Radius.circular(botR)),
        border:
            Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1),
        color: color);
  }
}
