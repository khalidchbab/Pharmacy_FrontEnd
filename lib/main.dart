import 'package:flutter/material.dart';
import 'package:fluttergooglemapsapp/views/main1.dart';
import 'views/homepage.dart';
import 'views/main1.dart';
import 'models/CityList.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter GoogleMaps Demo',
      theme: ThemeData(
        primaryColor: Color(0xff6200ee),
      ),
      home: CityList(city:"tanger"),
    );
  }
}