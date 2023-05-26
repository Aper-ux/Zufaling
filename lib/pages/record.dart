import 'package:flutter/material.dart';
import '../classes/user.dart';

// ignore: camel_case_types
class record extends StatefulWidget {
  const record({super.key});

  static const String id = 'record';

  @override
  State<record> createState() => _recordState();
}

// ignore: camel_case_types
class _recordState extends State<record> {
  @override
  Widget build(BuildContext context) {
    /* get arguments */
    final dynamic args = ModalRoute.of(context)?.settings.arguments;
    final us = args['user'];

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        /* change the back button to white */
        iconTheme: const IconThemeData(color: Colors.white),
        /* erase shadow */
        elevation: 0,
        backgroundColor: Colors.transparent,
        /* center the title at the center of the screen */
        centerTitle: true,
        title: const Text('Registro',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        /* increment the height */
        toolbarHeight: 70,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 600,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /* Show user */
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        '$us',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
