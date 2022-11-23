import 'package:flutter/material.dart';
import 'HomeView.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // 메인에서 비동기 작업을 할 때 사용
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  // Hive Init
  var box = await Hive.openBox('myBox', path: directory.path);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '굿헤빗',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Agrro'),
      home: const HomeWidget(),
    );
  }
}
