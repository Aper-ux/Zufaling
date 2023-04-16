import 'package:flutter/material.dart';
import 'pages/wellcome.dart';
import 'pages/tutorial.dart';
import 'pages/login.dart';
import 'pages/rutinas.dart';
import 'pages/wall.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LateralidApp',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.deepOrange,
          primarySwatch: Colors.orange,
        ),
        initialRoute: wellcome.id,
        routes: {
          wellcome.id: (context) => const wellcome(),
          tutorial.id: (context) => const tutorial(),
          login.id: (context) => const login(),
          rutinas.id: (context) => const rutinas(),
          wall.id: (context) => const wall(),
        });
  }
}
