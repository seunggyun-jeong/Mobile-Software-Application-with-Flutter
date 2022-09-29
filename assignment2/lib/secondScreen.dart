import 'package:flutter/material.dart';
import 'package:assignment2/animalItem.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.title});

  final String title;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Animal> animalList = new List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animalList.add(Animal(name: "벌", kind: "곤충", path: "images/bee.png", flying: true));
    animalList.add(Animal(name: "고양이", kind: "포유류", path: "images/cat.png"));
    animalList.add(Animal(name: "소", kind: "포유류", path: "images/cow.png"));
    animalList.add(Animal(name: "개", kind: "포유류", path: "images/dog.png"));
    animalList.add(Animal(name: "여우", kind: "포유류", path: "images/fox.png"));
    animalList.add(Animal(name: "개구리", kind: "양서류", path: "images/frog.png"));
    animalList.add(Animal(name: "원숭이", kind: "포유류", path: "images/monkey.png"));
    animalList.add(Animal(name: "돼지", kind: "포유류", path: "images/pig.png"));
    animalList.add(Animal(name: "늑대", kind: "포유류", path: "images/wolf.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: animalList.length,
        itemBuilder: (context, position) {
        return Card(
            child: Row(
              children: <Widget>[
                Image.asset(animalList[position].path!,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
                ),
                Text(animalList[position].name!)
              ]
            ),
          );
        }
      ),
    );
  }
}
