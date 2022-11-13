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
        body: Container(
          alignment: Alignment.center,
          child: Text("절연모드 설정"),
        ));
  }
}
