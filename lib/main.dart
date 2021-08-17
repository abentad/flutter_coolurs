import 'package:coolurs/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: mainBackgroundColor,
    statusBarIconBrightness: Brightness.dark, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coolurs',
      theme: ThemeData(
        scaffoldBackgroundColor: mainBackgroundColor,
        primarySwatch: Colors.purple,
      ),
      home: HomeScreen(),
    );
  }
}
