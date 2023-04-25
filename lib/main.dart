import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/wellcome.dart';
import 'pages/tutorial.dart';
import 'pages/login.dart';
import 'pages/rutinas.dart';
import 'pages/wall.dart';
import 'package:camera/camera.dart';
import 'pages/record.dart';
import 'vision_detector/pose_detector_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final cameras = await availableCameras();
  setup();
  runApp(MainApp(cameras: cameras));
}

/* Splash Screen setup */
void setup() async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
}

class MainApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MainApp({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CordinAPP',
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
          poseDetectorView.id: (context) => poseDetectorView(cameras: cameras),
          record.id: (context) => const record(),
        });
  }
}
