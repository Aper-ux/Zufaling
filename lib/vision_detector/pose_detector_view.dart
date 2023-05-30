import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:camera/camera.dart';
import 'package:zufaling/classes/bubles.dart';
import 'package:zufaling/classes/trainings.dart';
import 'package:zufaling/painters/pose_painter.dart';
import 'package:zufaling/pages/camera.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../classes/user.dart';
import '../classes/rutines.dart';
import '../dto/rutinesDto.dart';

class PoseDetectorView extends StatefulWidget {
  final List<CameraDescription> cameras;
  final List<Buble> bubles;
  final Training training;
  final String user;
  const PoseDetectorView(
      {Key? key,
      required this.cameras,
      required this.bubles,
      required this.training,
      required this.user})
      : super(key: key);

  static String id = 'pose_detector';

  @override
  PoseDetectorViewState createState() => PoseDetectorViewState();
}

class PoseDetectorViewState extends State<PoseDetectorView> {
  bool dialogFlag = false;
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
    PermissionStatus status = await Permission.microphone.request();
    if (status.isGranted) {
      // El permiso del micrófono ha sido concedido.
      //print('Permiso concedido');
    }

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
      if (widget.bubles.indexOf(widget.training.actualBuble!) + 1 ==
              widget.bubles.length &&
          !dialogFlag) {
        for (Buble buble in widget.bubles) {
          buble.visible = false;
        }
        widget.training.setActualBuble(widget.bubles.first);
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
            completed: 'si');

        insertRutine(rutineData);
        print(rutineData.toString());

        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, 'rutinas',
            arguments: {'user': widget.user});
        // ignore: use_build_context_synchronously
        showAlertDialog(context, widget.user);

        print('Fin de entrenamiento');
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
      training: widget.training,
      user: widget.user,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  void showAlertDialog(BuildContext context, String user) {
    dialogFlag = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                '¡Felicidades $user!',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              content: const Text(
                'Acabas de terminar tu rutina!',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
