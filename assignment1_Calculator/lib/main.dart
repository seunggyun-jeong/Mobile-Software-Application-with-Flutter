import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '과제 1 사칙연산 계산기 만들기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.]'(),
      home: Scaffold(
        appBar: AppBar(title: const Text('과제 1 사칙연산 계산기 만들기')),
        body: calculator()
      )
    );
  }
}
class calculator extends StatefulWidget {
  const calculator({Key? key}) : super(key: key);

  @override
  State<calculator> createState() => new _calculatorState();
}

class _calculatorState extends State<calculator> {
  String _result = "";

  TextEditingController val1 = TextEditingController();
  TextEditingController val2 = TextEditingController();

  void add() {
    setState(() {
      int result = int.parse(val1.value.text) + int.parse(val2.value.text);
      _result = '$result';
      print('$result');
    });
  }

  void subtract() {
    setState(() {
      int result = int.parse(val1.value.text) - int.parse(val2.value.text);
      _result = '$result';
      print('$result');
    });
  }

  void multiply() {
    setState(() {
      int result = int.parse(val1.value.text) * int.parse(val2.value.text);
      _result = '$result';
      print('$result');
    });
  }

  void divide() {
    setState(() {
      double result = int.parse(val1.value.text) / int.parse(val2.value.text);
      _result = '$result';
      print('$result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center (
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
              const Text('계산기 입니당'),
              TextField(
                decoration: const InputDecoration(
                  labelText: '첫 번째 숫자',
                ),
                keyboardType: TextInputType.number,
                controller: val1,
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: '두 번째 숫자'
                ),
                keyboardType: TextInputType.number,
                controller: val2,
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                onPressed: add,
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.add),
                    Text('\더해보자!'),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: subtract,
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.exposure_minus_1),
                    Text('\t빼보자!'),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                onPressed: multiply,
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.one_x_mobiledata),
                    Text('\t곱해보자!'),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo)),
                onPressed: divide,
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.safety_divider),
                    Text('\t나눠보자!'),
                  ],
                ),
              ),
              Text('결과 값 = $_result'),
            ],
          ),
        ),
      ),
    );
  }
}