import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:zufaling/painters/coordinates_translator.dart';

class Buble {
  bool visible = false;
  Offset position = const Offset(0, 0);
  double radius = 40.0;
  Color color = Colors.red;
  double strokeWidth = 4.0;
  PoseLandmarkType detector = PoseLandmarkType.leftWrist;

  Buble(this.visible, this.position, this.radius, this.color, this.strokeWidth,
      this.detector);

  void setVisibility(bool visible) {
    this.visible = visible;
  }

  void setPosition(Offset position) {
    this.position = position;
  }

  void setRadius(double radius) {
    this.radius = radius;
  }

  void setColor(Color color) {
    this.color = color;
  }

  void setStrokeWidth(double strokeWidth) {
    this.strokeWidth = strokeWidth;
  }


  bool getVisibility() {
    return visible;
  }

  Offset getPosition() {
    return position;
  }

  double getRadius() {
    return radius;
  }

  Color getColor() {
    return color;
  }

  double getStrokeWidth() {
    return strokeWidth;
  }


  void draw(Canvas canvas) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(position, radius, paint);
  }
  
  @override
  String toString() {
    return 'Buble{visible: $visible, position: $position, radius: $radius, color: $color, strokeWidth: $strokeWidth, detector: $detector}';
  }

  bool isInside(Pose pose, InputImageRotation rotation, Size size,
      Size absoluteImageSize) {
    PoseLandmark poseLandmark = pose.landmarks[this.detector]!;
    Offset detector = Offset(
        translateX(poseLandmark.x, rotation, size, absoluteImageSize),
        translateY(poseLandmark.y, rotation, size, absoluteImageSize));
    return (detector.dx - position.dx) * (detector.dx - position.dx) +
            (detector.dy - position.dy) *
                (detector.dy - position.dy) <
        radius * radius;
  }
}
