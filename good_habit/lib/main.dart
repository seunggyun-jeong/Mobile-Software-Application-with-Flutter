import 'package:flutter/material.dart';
import 'HomeView.dart';

void main() {
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
