import 'package:flutter/material.dart';

class SetBreakMode extends StatefulWidget {
  const SetBreakMode({super.key});

  @override
  State<SetBreakMode> createState() => _SetBreakModeState();
}

class _SetBreakModeState extends State<SetBreakMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("금연 모드 설정"),
          backgroundColor: Colors.pink,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text("금연 모드 설정"),
        ));
  }
}
