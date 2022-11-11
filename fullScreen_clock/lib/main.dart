import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // 테마에서 모든 폰트를 통일 시킬 수 있음.
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
          fontFamily: '7segment'
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late String time; // null이 뜨지 않도록 나중에 처리하겠다는 약속 (late)
  late String date;
  Duration durationTime = Duration();
  Duration durationDate = Duration();

  void setTime() {
    setState(() {
      time = DateFormat('hh:mm:ss').format(DateTime.now().add(durationTime));
      date = DateFormat('yyyy-MM-dd').format(DateTime.now().add(durationDate));
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTime();
    Timer.periodic(const Duration(seconds: 1), (timer) => setTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () async {
                  DateTime? dt = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(3000),
                      builder: (BuildContext context, Widget? w) {
                        return Theme(
                          data: ThemeData.dark(),
                          child: w!,
                        );
                      }, initialDate: DateTime.now()
                  );
                  if(dt == null) return;
                  DateTime end = DateTime.now();
                  DateTime begin = DateTime(dt.year, dt.month, dt.day);
                  durationDate = begin.difference(end);
                  setTime();
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Stack(
                      children: [
                        const Text('8888-88-88', style: TextStyle(color: Colors.white24)),
                        Text(date, style: const TextStyle(color: Colors.white))
                    ]
                    )
                  ),
                )
            ),
            GestureDetector(
              onTap: () async {
                TimeOfDay? dt = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (BuildContext context, Widget? w) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: w!,
                      );
                    }
                );
                if(dt == null) return;
                DateTime end = DateTime.now();
                DateTime begin = DateTime(end.year, end.month, end.day, dt.hour, dt.minute, end.second);
                durationTime = begin.difference(end);
                setTime();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.1,
                child: FittedBox(
                fit: BoxFit.contain,
                child: Stack(
                  children: [
                  const Text('88:88:88', style: TextStyle(color: Colors.white24)),
                  Text(time, style: const TextStyle(color: Colors.white))
                ]
                ),
              ),
              )
            )
          ],
        ),
      ),
    );
  }
}
