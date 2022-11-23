// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:good_habit/HomeView.dart';
import 'package:good_habit/SetCutDownModeView.dart';
import 'dart:async';
import 'package:hive/hive.dart';

class CutDownView extends StatefulWidget {
  const CutDownView({super.key});

  @override
  State<CutDownView> createState() => _CutDownViewState();
}

class _CutDownViewState extends State<CutDownView> {
  // Variable
  // 통계 관련 변수
  int count = 0;
  int setCount = 0;
  int money = 0;
  int nicotine = 0;
  int tar = 0;

  // 습관 분석 관련 변수
  Duration setTime = const Duration(hours: 1);
  late DateTime nowTime;
  late DateTime finishTime;
  int leftTime = 0;
  bool isTimerPlaying = false;

  int hour = 0;
  int min = 0;
  int sec = 0;

  // Hive box
  final _myBox = Hive.box('myBox');

  // Method
  // 버튼 터치시 동작하는 메서드
  void incrementCounter() {
    setState(() {
      // 한 번 터치 시 할당량 한 개비 감소
      setCount--;
      // 한 번 터치 시 한 개비 증가
      count++;

      calculator();

      // 타이머 종료시간 저장
      nowTime = DateTime.now();
      finishTime = nowTime.add(setTime);

      setTimer(nowTime);
      saveData();
    });
  }

  // 통계 데이터 계산
  void calculator() {
    setState(() {
      // 담배 한 개비 당 225원
      money = count * 225;
      // 담배 한 개비 당 약 1mg 니코틴 흡입
      nicotine = count * 1;
      // 담배 한 개비 당 약 10mg 타르 흡입
      tar = count * 10;
    });
  }

  void saveData() {
    _myBox.put('remainingCount', setCount);
    _myBox.put('count', count);
  }

  // 타이머 시작 가능 여부 체크 메서드
  bool canTimerPlay() {
    if (setCount > 0 && !isTimerPlaying) {
      return false;
    } else {
      return true;
    }
  }

  // 타이머 설정 메서드
  void setTimer(DateTime startTime) {
    setState(() {
      isTimerPlaying = true;
      leftTime = finishTime.difference(startTime).inSeconds;

      _myBox.put('finishTime', finishTime);
      print("finish Time : ${_myBox.get('finishTime')}");

      // 타이머 시작
      Timer.periodic(const Duration(seconds: 1), (timer) {
        // 타이머가 0이 되면 타이머 정지
        late bool timeChecker;
        timeChecker = startTimer();
        if (timeChecker == false) {
          timer.cancel();
          isTimerPlaying = false;
        }
      });
    });
  }

  // 타이머 동작 메서드
  bool startTimer() {
    late bool isRemainTime;
    setState(() {
      if (leftTime > 0) {
        leftTime--;
        hour = leftTime ~/ 3600;
        min = (leftTime % 3600) ~/ 60;
        sec = ((leftTime % 3600) % 60);
        isRemainTime = true;
      } else {
        isRemainTime = false;
      }
    });
    return isRemainTime;
  }

  // Key 값으로 디스크에 저장된 데이터 불러오는 메서드
  // Hive 사용
  void _loadData() {
    setState(() {
      // 현재 시간 저장
      nowTime = DateTime.now();

      // hive db에서 데이터 불러오기
      var timeSlot = _myBox.get('timeSlot', defaultValue: 1);
      finishTime = _myBox.get('finishTime', defaultValue: DateTime.now());
      setCount =
          _myBox.get('remainingCount', defaultValue: _myBox.get('alloc'));
      setTime = Duration(minutes: timeSlot);
      count = _myBox.get('count', defaultValue: 0);

      calculator();
    });
  }

  // 앱 내부 데이터 초기화 메서드
  // hive 사용
  void _reinitialize() {
    _myBox.delete('alloc');
    _myBox.delete('timeSlot');
    _myBox.delete('remainingCount');
    _myBox.delete('finishTime');
    _myBox.delete('count');
    _myBox.delete('modeType');
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => const HomeWidget(),
      ),
      (Route route) => false,
    );
  }

  // 앱 바의 우측 설정 버튼 메서드
  void _reset() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SetCutDownMode()));
  }

  @override
  void initState() {
    super.initState();
    // 저장된 데이터 불러오기
    _loadData();
    // 타이머 종료 시간 저장
    var remainingTime = finishTime.difference(nowTime).inSeconds;
    print('remainingTime == $remainingTime');
    // 남은 시간이 있으면 타이머 재생
    if (remainingTime > 0) {
      setTimer(nowTime);
    }
  }

  // View
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar 설정
      appBar: AppBar(
        title: const Text("절연모드"),
        backgroundColor: Colors.pink,
        leading: TextButton(
            onPressed: _reinitialize,
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: const Text("초기화")),
        actions: [
          // App Bar의 우측 버튼
          TextButton(
              onPressed: _reset,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text("설정")),
        ],
      ),
      body: Container(
          color: const Color.fromARGB(255, 197, 149, 170),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: statisticsSection(),
                  ),
                  smokingSlotSection()
                ]),
          )),
      // 흡연 카운트 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: canTimerPlay() ? null : incrementCounter,
        backgroundColor: canTimerPlay() ? Colors.grey : Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }

  // 흡연 간격 세션
  Column smokingSlotSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: customBoxStyle(
              10, 10, 0, 0, const Color.fromARGB(255, 249, 72, 146)),
          child: const Text(
            "흡연 간격",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: customBoxStyle(
              0, 0, 10, 10, const Color.fromARGB(255, 251, 229, 229)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [setTimeSection(), remainingTimeSection()]),
        ),
      ],
    );
  }

  // 흡연 간격 섹션 - 설정 시간 섹션
  Column setTimeSection() {
    return Column(
      children: [
        const Text(
          "설정 시간",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 80,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
                '${'${setTime.inMinutes ~/ 60}'.padLeft(2, '0')}:${'${setTime.inMinutes % 60}'.padLeft(2, '0')}:00',
                style: const TextStyle(fontFamily: 'MonoSpace')),
          ),
        ),
      ],
    );
  }

  // 흡연 간격 섹션 - 남은 시간 섹션
  Column remainingTimeSection() {
    return Column(
      children: [
        const Text(
          "남은 시간",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 80,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Text(
                '${'$hour'.padLeft(2, '0')}:${'$min'.padLeft(2, '0')}:${'$sec'.padLeft(2, '0')}',
                style: const TextStyle(fontFamily: 'MonoSpace')),
          ),
        ),
      ],
    );
  }

  // 통계 섹션
  Column statisticsSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: customBoxStyle(
              10, 10, 0, 0, const Color.fromARGB(255, 249, 72, 146)),
          child: const Text(
            "통계",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: customBoxStyle(
              0, 0, 10, 10, const Color.fromARGB(255, 251, 229, 229)),
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

  // 통계 섹션 - 표시할 행
  // Reusable
  Row statisticsRow(String title, int value, String unit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerRight,
          child: Text(
            "$title : ",
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

  // 사용자 정의 박스 스타일
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
