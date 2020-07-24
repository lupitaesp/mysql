import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(MaterialApp(
  home:new MyApp(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Carter'),
));

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Carter'),
      title: 'Flutter Demo',
      home: homepage(),
    );
  }
}