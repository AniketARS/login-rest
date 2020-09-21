import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Now",
      theme: ThemeData(primaryColor: Color.fromRGBO(177, 30, 49, 1)),
      home: HomeScreen(),
    );
  }
}
