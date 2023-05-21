import 'package:flutter/cupertino.dart';

import 'bubles.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';


class Training {
  static var trainings = {
    "Facil": [
      Buble(false, Offset(300.0, 300.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
      Buble(false, Offset(100.0, 100.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
      Buble(false, Offset(150.0, 150.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
      Buble(false, Offset(200.0, 200.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
      Buble(false, Offset(250.0, 250.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
    ],
    "Medio": [
      Buble(false, Offset(300.0, 600.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
      Buble(false, Offset(100.0, 650.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
      Buble(false, Offset(150.0, 700.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
      Buble(false, Offset(200.0, 750.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
      Buble(false, Offset(250.0, 800.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
    ],
    "Dificil": [
      Buble(false, Offset(300.0, 300.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
      Buble(false, Offset(100.0, 100.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
      Buble(false, Offset(150.0, 150.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
      Buble(false, Offset(200.0, 200.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
      Buble(false, Offset(250.0, 250.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
    ],
  };

  Buble? actualBuble; 

  Training(Buble this.actualBuble){
    actualBuble!.setVisibility(true);
  }

  void setActualBuble(Buble buble){
    actualBuble = buble;
    actualBuble!.setVisibility(true);
  }

  Buble? getActualBuble(){
    return actualBuble;
  }

}
