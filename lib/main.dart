import 'package:flutter/material.dart';
import 'package:lcogym/screens/homeScreen/home.dart';
import 'package:lcogym/screens/loginScreen/login.dart';
import 'package:lcogym/screens/select.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lco Workout',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}