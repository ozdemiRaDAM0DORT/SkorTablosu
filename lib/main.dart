import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score_board_2/sayfalar/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Score Board',
      home: HomePage(),
    );
  }
}
