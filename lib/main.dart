import 'package:flutter/material.dart';
import 'package:todomobx/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estudando Mobx',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.redAccent,
          cursorColor: Colors.redAccent,
          scaffoldBackgroundColor: Colors.redAccent),
      home: LoginScreen(),
    );
  }
}
