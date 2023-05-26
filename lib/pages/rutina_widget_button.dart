import 'package:flutter/material.dart';
import 'package:zufaling/classes/trainings.dart';
import 'package:zufaling/classes/bubles.dart';

class RutinaWidgetButton extends StatelessWidget {
  const RutinaWidgetButton(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.description,
      required this.bubles,})
      : super(key: key);
  final String name;
  final String imageUrl;
  final String description;
  final List<Buble> bubles;

  @override
  Widget build(BuildContext context) {
    final Training training = Training(bubles.first);
    return Container(
      height: 100,
      padding: const EdgeInsets.all(15),
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
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                ),
              ),
              child: const SizedBox(
                width: 150,
                height: 150,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 18,
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
