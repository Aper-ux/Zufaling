import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:camera/camera.dart';
import 'package:zufaling/classes/bubles.dart';
import 'package:zufaling/classes/trainings.dart';
import 'package:zufaling/painters/pose_painter.dart';
import 'package:zufaling/pages/camera.dart';

class PoseDetectorView extends StatefulWidget {
  final List<CameraDescription> cameras;
  final List<Buble> bubles;
  final Training training;
  const PoseDetectorView({Key? key, required this.cameras, required this.bubles, required this.training}) : super(key: key);

  static String id = 'pose_detector';
  
  @override
  PoseDetectorViewState createState() => PoseDetectorViewState();
}

class PoseDetectorViewState extends State<PoseDetectorView> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  //CustomPaint? bublesPainter;

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
      final painter = PosePainter(
          widget.training,
          widget.bubles,
          poses,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
      //Control de final de entrenamiento
      if(widget.bubles.indexOf(widget.training.actualBuble!) == widget.bubles.length - 1){
        //TODO: Mostrar pantalla de fin de entrenamiento
        print('Fin de entrenamiento');
        Navigator.pop(context); 
      }
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
