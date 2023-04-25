import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:camera/camera.dart';
import 'package:zufaling/painters/pose_painter.dart';
import 'package:zufaling/pages/camera.dart';

class poseDetectorView extends StatefulWidget {
  final List<CameraDescription> cameras;
  const poseDetectorView({Key? key, required this.cameras}) : super(key: key);

  static String id = 'pose_detector';

  @override
  _poseDetectorViewState createState() => _poseDetectorViewState();
}

class _poseDetectorViewState extends State<poseDetectorView> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  @override
  void dispose() {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;
    _isBusy = true;
    setState(() {});
    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(poses, inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return camera(
      cameras: widget.cameras,
      customPaint: _customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }
}
