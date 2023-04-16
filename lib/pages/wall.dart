import 'package:flutter/material.dart';

// ignore: camel_case_types
class wall extends StatefulWidget {
  const wall({super.key});

  static String id = 'wall';

  @override
  State<wall> createState() => _wallState();
}

// ignore: camel_case_types
class _wallState extends State<wall> {
  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/r1.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
