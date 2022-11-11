import 'package:flutter/material.dart';


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
            Image.asset('images/noSmoking.png',
                        width: 250,
                        height: 250,),

            // 텍스트의 범위를 지정하기 위해 Sized Box 사용
            const SizedBox(
              width: 300,
              child: Text("아직 좋은 습관을 만들기 위해 다짐하지 않았어요!",
                        style: TextStyle(fontFamily: 'Agrro',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                                textAlign: TextAlign.center,
                                ),
            ),
            
          ],
        ),
      ),
    );
  }
}