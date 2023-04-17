import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'camera_widget.dart';
=======
import 'pages/wellcome.dart';
import 'pages/tutorial.dart';
import 'pages/login.dart';
import 'pages/rutinas.dart';
import 'pages/wall.dart';
>>>>>>> 5fd4d3ac4d88d4eb1671d9c1445b89cd522491ff

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Camera Stream Demo',
      home: CameraScreen(cameras: cameras),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen({
    Key? key,
    required this.cameras,
  }) : super(key: key);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isStreaming = false;
  final ValueNotifier<int> _selectedCameraIndex = ValueNotifier(0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Start streaming images from the camera.
  void startStream() async {
    await _controller.startImageStream((image) {
      // Process the image bytes here.
    });
  }

  // Toggle streaming images from the camera.
  void _toggleStreaming() async {
    if (!_isStreaming) {
      // Start streaming images from the camera.
      _controller = CameraController(
        widget.cameras[_selectedCameraIndex.value],
        ResolutionPreset.veryHigh,
      );
      await _controller.initialize();
      startStream();
    } else {
      // Stop streaming images from the camera.
      await _controller.stopImageStream();
      await _controller.dispose();
    }

    setState(() {
      // Update _isStreaming state when changes on _toggleStreaming().
      _isStreaming = !_isStreaming;
    });
  }

  //  Toggle between the front and back camera.
  void _toggleCamera() async {
    // Select the next camera in cameras list.
    _selectedCameraIndex.value =
        (_selectedCameraIndex.value + 1) % widget.cameras.length;

    // Stop streaming images from the camera.
    await _controller.dispose();
    // Start streaming images from the new camera.
    _controller = CameraController(
      widget.cameras[_selectedCameraIndex.value],
      ResolutionPreset.veryHigh,
    );
    // Initialize the new camera.
    await _controller.initialize();

    if (_isStreaming) {
      // Start streaming images from the new camera.
      startStream();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Stream Demo')),
      body: Center(
        child: _isStreaming
            ? AspectRatio(
                aspectRatio: 1 / _controller.value.aspectRatio,
                child: CameraPreviewWidget(cameraController: _controller),
              )
            : const Text('Tap the button to start the camera stream.'),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: _toggleStreaming,
          child: Icon(_isStreaming ? Icons.stop : Icons.play_arrow),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: _toggleCamera,
          child: const Icon(Icons.switch_camera),
        ),
      ]),
    );
  }
}

class CameraPreviewWidget extends StatelessWidget {
  final CameraController cameraController;

  const CameraPreviewWidget({Key? key, required this.cameraController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return  Expanded(
      child: AspectRatio(
        aspectRatio: cameraController.value.aspectRatio / deviceRatio,
        child: CameraPreview(cameraController),
        ),
      );
  }
}
=======
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
>>>>>>> 5fd4d3ac4d88d4eb1671d9c1445b89cd522491ff
