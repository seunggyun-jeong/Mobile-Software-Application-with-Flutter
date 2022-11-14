import 'package:flutter/material.dart';
import './SetBreakModeView.dart';
import 'SetCutDownModeView.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 로고 이미지
            LogoImage(),
            // 설명
            Description(),
            // 사용 시작 버튼 : 절연모드, 금연모드
            StartButtons()
          ],
        ),
      ),
    );
  }

  Row StartButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StartButton(const SetCutDownMode(), "절연모드로 시작하기"),
        _StartButton(const SetBreakMode(), "금연모드로 시작하기"),
      ],
    );
  }

  ElevatedButton _StartButton(Widget view, String label) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => view));
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
        child: Text(label));
  }

  Padding Description() {
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

  Padding LogoImage() {
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
