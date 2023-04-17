import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class CameraPage extends StatelessWidget{

  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras(),
      builder: (context, AsyncSnapshot<List<CameraDescription>> snapshot){
        if(snapshot.hasData){
          return Camera(controller: CameraController(snapshot.data![0], ResolutionPreset.high),);
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

}

class Camera extends StatelessWidget{
  final CameraController controller;

  const Camera({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
      );
  }

}

