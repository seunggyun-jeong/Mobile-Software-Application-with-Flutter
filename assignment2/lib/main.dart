import 'package:flutter/material.dart';

import 'package:assignment2/firstScreen.dart';
import 'package:assignment2/secondScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
                        with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TabBarView(
        children: [
          FirstScreen(title: "1"),
          SecondScreen(title: "2")
        ],
        controller: controller,
        ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.add, color: Colors.blue)),
          Tab(icon: Icon(Icons.abc, color: Colors.red))
      ],
      controller: controller,
      ),
    );
  }
}
