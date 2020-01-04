import 'package:flutter/material.dart';
import 'HapaHome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hapa',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.black,
        primaryIconTheme: IconThemeData(color: Colors.black),
        primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.black,fontFamily: "Aveny")
        )
      ),
      home: new HapaHome(),
    );
  }

}