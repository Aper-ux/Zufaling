import 'package:flutter/material.dart';

// ignore: camel_case_types
class wellcome extends StatefulWidget {
  const wellcome({super.key});

  static String id = 'wellcome';

  @override
  State<wellcome> createState() => _wellcomeState();
}

// ignore: camel_case_types
class _wellcomeState extends State<wellcome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenido a',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const Text('CordinAPP',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 350,
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
              child: const SingleChildScrollView(
                child: Center(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, 'tutorial');
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    ));
  }
}
