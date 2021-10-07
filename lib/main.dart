import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:showroom_backend/temp/homepage.dart';
import 'package:showroom_backend/views/login/login_screen.dart';

void main() {


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
