import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:intl/intl.dart';

import '../classes/rutines.dart';
import '../classes/trainings.dart';
import '../classes/user.dart';

// ignore: camel_case_types
class camera extends StatefulWidget {
  final Training training;
  final String user;
  const camera(
      {Key? key,
      required this.cameras,
      required this.customPaint,
      //required this.bubles_painter,
      required this.onImage,
      required this.training,
      required this.user,
      this.initialDirection = CameraLensDirection.front})
      : super(key: key);

  final List<CameraDescription> cameras;
  final CustomPaint? customPaint;
  //final CustomPaint? bubles_painter;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;
  @override
  State<camera> createState() => _cameraState();
}

class _cameraState extends State<camera> with WidgetsBindingObserver{
  CameraController? _controller;

  int _cameraIndex = -1;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  bool _changingCameraLens = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.cameras.any(
      (element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = widget.cameras.indexOf(
        widget.cameras.firstWhere((element) =>
            element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      for (var i = 0; i < widget.cameras.length; i++) {
        if (widget.cameras[i].lensDirection == widget.initialDirection) {
          _cameraIndex = i;
          break;
        }
      }
    }
    
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopLiveFeed();
    super.dispose();
  }

  @override
void didChangeAppLifecycleState(AppLifecycleState state) {
  final CameraController? cameraController = _controller;

  // App state changed before we got the chance to initialize.
  if (cameraController == null || !cameraController.value.isInitialized) {
    return;
  }

  if (state == AppLifecycleState.inactive) {
    _stopLiveFeed();  // calls cameraController.dispose();
  } else if (state == AppLifecycleState.resumed) {
    _startLiveFeed();  // calls _initializeCameraController(cameraController.description);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget? _floatingActionButton() {
    return ScaffoldMessenger(
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () async {
            final users = await searchUser(widget.user);

            // Obtener el id del user users
            int? id = users[0].id;

            // Insertar rutina completada en rutinas
            DateTime now = DateTime.now();
            String formattedDate = DateFormat('dd/MM/yyyy').format(now);
            String formattedTime = DateFormat('HH:mm:ss').format(now);
            String date = '$formattedDate - $formattedTime';
            final rutineData = Rutines(
                userId: id,
                rutine: widget.training.name,
                date: date,
                completed: 'no');

            insertRutine(rutineData);
            print(rutineData.toString());

            Navigator.pop(context);
          },
          child: const Icon(Icons.stop_rounded),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: _switchLiveCamera,
          child: const Icon(Icons.switch_camera_outlined),
        ),
      ]),
    );
  }

  Widget _body() {
    Widget body;
    body = _liveFeedBody();
    return body;
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return const CircularProgressIndicator();
    }

    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * _controller!.value.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.scale(
            scale: scale,
            child: Center(
              child: _changingCameraLens
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CameraPreview(_controller!),
            ),
          ),
          if (widget.customPaint != null) widget.customPaint!,
          //if (widget.bubles_painter != null) widget.bubles_painter!,
        ],
      ),
    );
  }

  Future _startLiveFeed() async {
    final camera = widget.cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        zoomLevel = value;
        minZoomLevel = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
      });
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % widget.cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = widget.cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
