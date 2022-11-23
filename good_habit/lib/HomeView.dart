// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:good_habit/CutDownView.dart';
import 'package:good_habit/type.dart';
import 'package:hive/hive.dart';
import './SetBreakModeView.dart';
import 'SetCutDownModeView.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  ModeType modeType = ModeType.none;

  // Hive Box 불러오기
  final _myBox = Hive.box('myBox');

  void _loadData() {
    setState(() {
      switch (_myBox.get('modeType', defaultValue: 0)) {
        case 0:
          modeType = ModeType.none;
          break;
        case 1:
          modeType = ModeType.cutDownMode;
          break;
        case 2:
          modeType = ModeType.breakMode;
          break;
      }
      print("modeType ---> $modeType");
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: modeType == ModeType.cutDownMode
            ? const CutDownView()
            : modeType == ModeType.breakMode
                ? const SetBreakMode()
                : firstView(),
      ),
    );
  }

  Column firstView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // 로고 이미지
        logoImage(),
        // 설명
        description(),
        // 사용 시작 버튼 : 절연모드, 금연모드
        startButtons()
      ],
    );
  }

  Row startButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _startButton(const SetCutDownMode(), "절연모드로 시작하기"),
        _startButton(const SetBreakMode(), "금연모드로 시작하기"),
      ],
    );
  }

  ElevatedButton _startButton(Widget view, String label) {
    return ElevatedButton(
        onPressed: () {
          if (label == "금연모드로 시작하기") {
            _myBox.put('modeType', 2);
            _myBox.put('breakModeSetTime', DateTime.now());
            print('modeType --> ${_myBox.get('modeType')}');
            print('setTime --> ${_myBox.get('breakModeSetTime')}');
          }
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => view,
            ),
            (Route route) => false,
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
        child: Text(label));
  }

  Padding description() {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      // 텍스트의 범위를 지정하기 위해 Sized Box 사용
      child: SizedBox(
        width: 300,
        child: Text(
          "아직 좋은 습관을 만들기 위해 \n다짐하지 않았어요!",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Padding logoImage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Image.asset(
        'images/noSmoking.png',
        width: 250,
        height: 250,
      ),
    );
  }
}
