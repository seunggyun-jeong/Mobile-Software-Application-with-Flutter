import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:good_habit/CutDownView.dart';

class SetCutDownMode extends StatefulWidget {
  const SetCutDownMode({super.key});

  @override
  State<SetCutDownMode> createState() => _SetCutDownModeState();
}

class _SetCutDownModeState extends State<SetCutDownMode> {
  int? inputVal = null;
  bool inputFieldIsEmpty = true;

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
                    InputTitleSection(),
                    InputFieldSection(),
                    SetButton(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Container SetButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: inputFieldIsEmpty
            ? null
            : () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CutDownView()));
              },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
        child: const Text("설정 완료"),
      ),
    );
  }

  Container InputFieldSection() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: TextField(
        onChanged: (value) => {
          setState(() {
            if (value.isNotEmpty) {
              inputVal = int.parse(value);
              inputFieldIsEmpty = false;
            } else {
              inputVal = 0;
              inputFieldIsEmpty = true;
            }
          })
        },
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: '개수 입력',
          hintText: '하루의 다짐을 입력하세요!',
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
    );
  }

  Container InputTitleSection() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: const Text(
        "하루 할당량 설정",
        style: TextStyle(
          fontSize: 40,
        ),
      ),
    );
  }
}
