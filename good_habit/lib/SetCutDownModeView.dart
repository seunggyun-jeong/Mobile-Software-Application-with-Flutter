import 'package:flutter/material.dart';

class SetCutDownMode extends StatefulWidget {
  const SetCutDownMode({super.key});

  @override
  State<SetCutDownMode> createState() => _SetCutDownModeState();
}

class _SetCutDownModeState extends State<SetCutDownMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("절연모드 설정"),
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "하루 할당량 설정",
                      style: TextStyle(
                        fontFamily: 'Agrro',
                        fontSize: 50,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
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
                    )
                  ]),
            ),
          ),
        ));
  }
}
