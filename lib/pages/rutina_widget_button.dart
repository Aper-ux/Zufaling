import 'package:flutter/material.dart';
import 'package:zufaling/classes/trainings.dart';
import 'package:zufaling/classes/bubles.dart';

class RutinaWidgetButton extends StatelessWidget {
  const RutinaWidgetButton(
      {Key? key,
      required this.name,
      required this.description,
      required this.bubles,
      required this.user,
      required this.trainingName})
      : super(key: key);
  final String name;
  final String description;
  final List<Buble> bubles;
  final String user;
  final String trainingName;

  @override
  Widget build(BuildContext context) {
    final Training training = Training(bubles.first, trainingName);
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color.fromARGB(208, 0, 0, 0),
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.white),
          left: BorderSide(width: 1.0, color: Colors.white),
          right: BorderSide(width: 1.0, color: Colors.white),
          bottom: BorderSide(width: 1.0, color: Colors.white),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'pose_detector', arguments: {
            'training': training,
            'bubles': bubles,
            'user': user,
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
