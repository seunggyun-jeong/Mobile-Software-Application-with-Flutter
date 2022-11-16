// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:good_habit/CutDownView.dart';
import './SetBreakModeView.dart';
import 'SetCutDownModeView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool isExistData = false;

  void _loadData() async {
    var key1 = 'alloc';
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value1 = pref.getInt(key1);
      if (value1 == null) {
        isExistData = false;
      } else {
        isExistData = true;
      }
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
        child: isExistData ? const CutDownView() : firstView(),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => view));
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
