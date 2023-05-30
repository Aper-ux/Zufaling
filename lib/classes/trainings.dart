
import 'bubles.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math';


class Training {
  static var pltList = [PoseLandmarkType.leftWrist, PoseLandmarkType.rightWrist, PoseLandmarkType.nose];
  static var colors = [Colors.white, Colors.deepOrange, Colors.red];
  String name = "";
  static var trainings = {
    "Facil": [
      Buble(false, const Offset(300.0, 300.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
      Buble(false, const Offset(100.0, 100.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
      Buble(false, const Offset(150.0, 150.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
      Buble(false, const Offset(200.0, 200.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
      Buble(false, const Offset(250.0, 250.0), 40.0, Colors.white, 4.0, PoseLandmarkType.leftWrist),
    ],
    "Medio": [
      Buble(false, const Offset(300.0, 600.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
      Buble(false, const Offset(100.0, 650.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
      Buble(false, const Offset(150.0, 700.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
      Buble(false, const Offset(200.0, 750.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
      Buble(false, const Offset(250.0, 800.0), 40.0, Colors.deepOrange, 4.0, PoseLandmarkType.rightWrist),
    ],
    "Dificil": [
      Buble(false, const Offset(300.0, 300.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
      Buble(false, const Offset(100.0, 100.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
      Buble(false, const Offset(150.0, 150.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
      Buble(false, const Offset(200.0, 200.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
      Buble(false, const Offset(250.0, 250.0), 40.0, Colors.red, 4.0, PoseLandmarkType.nose),
    ],
  };

  Buble? actualBuble; 

  Training(Buble this.actualBuble, this.name){
    actualBuble!.setVisibility(true);
  }

  static List<Buble> getRandomBubles(Size size){
    //generate random list 
    List<Buble> randomBubles = [];
    var random = Random();
    var max = random.nextInt(15)+10;
    for (var i = 0; i <= max; i++) {
      var random = Random();
      var randomIndex = random.nextInt(pltList.length);
      var randomOffset = Offset(random.nextInt(size.width.toInt()).toDouble(), random.nextInt(size.height.toInt()).toDouble());
      randomBubles.add(Buble(false, randomOffset, 40.0, colors[randomIndex], 4.0, pltList[randomIndex]));
    }
    //show content in randomBubles
    for(var i = 0; i < randomBubles.length; i++){
      print(randomBubles[i].toString());
    }
    return randomBubles;

  }

  void setActualBuble(Buble buble){
    actualBuble = buble;
    actualBuble!.setVisibility(true);
  }

  Buble? getActualBuble(){
    return actualBuble;
  }

}
