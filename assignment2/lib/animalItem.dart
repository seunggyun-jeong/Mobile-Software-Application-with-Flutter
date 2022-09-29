import 'package:flutter/material.dart';

class Animal {
  String? path;
  String? name;
  String? kind;
  bool? flying = false;

  Animal (
    {
      required this.name,
      required this.kind,
      required this.path,
      this.flying
    }
  );
}