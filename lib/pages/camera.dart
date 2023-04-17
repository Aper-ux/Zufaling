import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  const camera({Key? key, required this.cameras});

  static String id = 'camera';

  @override
  State<camera> createState() => _cameraState();
}

// ignore: camel_case_types
class _cameraState extends State<camera> {
  late CameraController _controller;
  final ValueNotifier<int> _selectedCameraIndex = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    // Initialize the camera controller.
    _controller = CameraController(
      widget.cameras[_selectedCameraIndex.value],
      ResolutionPreset.veryHigh,
    );
  }

  @override
  void dispose() async {
    _controller.dispose();
    super.dispose();
  }

  // Start streaming images from the camera.
  void startStream() async {
    await _controller.startImageStream((image) {
      // Process the image bytes here.
    });
  }

  //  Toggle between the front and back camera.
  void _toggleCamera() async {
    // Select the next camera in cameras list.
    _selectedCameraIndex.value =
        (_selectedCameraIndex.value + 1) % widget.cameras.length;

    // Stop streaming images from the camera.
    await _controller.stopImageStream();
    await _controller.dispose();

    // Start streaming images from the new camera.
    _controller = CameraController(
      widget.cameras[_selectedCameraIndex.value],
      ResolutionPreset.veryHigh,
    );

    // Initialize the new camera.
    await _controller.initialize();
    startStream();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _controller.initialize(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          startStream();
          return Scaffold(
      body: Center(
          child: AspectRatio(
        aspectRatio: 1 / _controller.value.aspectRatio,
        child: _controller.value.isInitialized
            ? CameraPreview(_controller)
            : const CircularProgressIndicator(),
      )),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'rutinas');
          },
          child: const Icon(Icons.stop),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: _toggleCamera,
          child: const Icon(Icons.switch_camera),
        ),
      ]),
    );
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
