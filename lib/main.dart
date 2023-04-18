import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/wellcome.dart';
import 'pages/tutorial.dart';
import 'pages/login.dart';
import 'pages/rutinas.dart';
import 'pages/wall.dart';
import 'pages/camera.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final cameras = await availableCameras();
  runApp(MainApp(cameras: cameras));
}

class MainApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MainApp({super.key, required this.cameras});

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
          camera.id: (context) => camera(cameras: cameras),
        });
  }
}
