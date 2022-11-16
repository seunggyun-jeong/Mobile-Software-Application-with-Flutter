// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:good_habit/CutDownView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetCutDownMode extends StatefulWidget {
  const SetCutDownMode({super.key});

  @override
  State<SetCutDownMode> createState() => _SetCutDownModeState();
}

class _SetCutDownModeState extends State<SetCutDownMode> {
  // Variable
  // 입력 관련 변수
  int? inputAlloc;
  int? inputTime;
  bool isInputAllocFieldEmpty = true;
  bool isInputTimeFieldEmpty = true;

  // Method
  // 입력 값을 내부 디스크에 저장하는 메서드
  // SharedPreferences Class
  void _setData(int alloc, int timeSlot) async {
    var key1 = 'alloc';
    var key2 = 'timeSlot';

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key1, alloc);
    pref.setInt(key2, timeSlot);
  }

  // 설정 완료 버튼 메서드 -> CutDownView로 이동
  void _setButtonMethod() {
    _setData(inputAlloc!, inputTime!);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => const CutDownView(),
      ),
      (Route route) => false,
    );
  }

  // Widget
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 화면 탭 시 키보드 내리기
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("절연모드 설정"),
          backgroundColor: Colors.pink,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    inputTitleSection(),
                    inputAllocFieldSection(),
                    inputTimeFieldSection(),
                    setButton(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  // 설정 완료 버튼
  Container setButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: !isInputTimeFieldEmpty && !isInputAllocFieldEmpty
            ? _setButtonMethod
            : null,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
        child: const Text("설정 완료"),
      ),
    );
  }

  // 담배 개수 입력 섹션
  Container inputAllocFieldSection() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
          onChanged: (value) => {
                setState(() {
                  if (value.isNotEmpty) {
                    inputAlloc = int.parse(value);
                    isInputAllocFieldEmpty = false;
                  } else {
                    inputAlloc = 0;
                    isInputAllocFieldEmpty = true;
                  }
                })
              },
          keyboardType: TextInputType.number,
          decoration: _customInputDecoration("개수 입력", "하루의 다짐을 입력하세요!")),
    );
  }

  // 흡연 시간 간격 입력 섹션
  Container inputTimeFieldSection() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        onChanged: (value) => {
          setState(() {
            if (value.isNotEmpty) {
              inputTime = int.parse(value);
              isInputTimeFieldEmpty = false;
            } else {
              inputTime = 0;
              isInputTimeFieldEmpty = true;
            }
          })
        },
        keyboardType: TextInputType.number,
        decoration:
            _customInputDecoration("시간 간격 입력", "흡연 시간 간격을 분 단위로 설정해주세요!"),
      ),
    );
  }

  // 사용자 정의 InputDecoration
  InputDecoration _customInputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Colors.black),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 1, color: Colors.black),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(width: 1, color: Colors.black),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  // 위젯 제목 섹션
  Container inputTitleSection() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: const Text(
        "하루 할당량 설정",
        style: TextStyle(
          fontSize: 40,
        ),
      ),
    );
  }
}
