import 'package:flutter/material.dart';
import 'package:zufaling/pages/rutina_widget_button.dart';
import 'package:zufaling/classes/trainings.dart';

// ignore: camel_case_types
class rutinas extends StatefulWidget {
  const rutinas({super.key});

  static String id = 'rutinas';

  @override
  State<rutinas> createState() => _rutinasState();
}

// ignore: camel_case_types
class _rutinasState extends State<rutinas> {
  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        /* erase back button */
        automaticallyImplyLeading: false,
        /* erase shadow */
        elevation: 0,
        backgroundColor: Colors.transparent,
        /* add title */
        /* center the title at the center of the screen */
        centerTitle: true,
        title: const Text('\nCordinAPP\nRutinas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        /* increment the height */
        toolbarHeight: 105,
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        childAspectRatio: 2 / 4,
        children: <Widget>[
          RutinaWidgetButton(
              name: 'Rutina demo 1',
              imageUrl: 'assets/images/r1.jpg',
              description: 'Descripcion rutina demo 1',
              bubles: Training.trainings['Facil']!,
              ),
          RutinaWidgetButton(
              name: 'Rutina demo 2',
              imageUrl: 'assets/images/r1.jpg',
              description: 'Descripcion rutina demo 2',
              bubles: Training.trainings['Medio']!,
              ),
          RutinaWidgetButton(
              name: 'Rutina demo 3',
              imageUrl: 'assets/images/r1.jpg',
              description: 'Descripcion rutina demo 3',
              bubles: Training.trainings['Dificil']!,
              ),
          RutinaWidgetButton(
              name: 'Random demo',
              imageUrl: 'assets/images/r1.jpg',
              description: 'Descripcion rutina random demo',
              bubles: Training.getRandomBubles(Size(370.0, 370.0)),   
              ),
          Container(
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
                Navigator.pushNamed(context, 'pose_detector');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Rutina 5',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/r1.jpg'),
                      ),
                    ),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                    ),
                  ),
                  Text(
                    'Descripcion de la rutina 5',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
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
                Navigator.pushNamed(context, 'pose_detector');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Rutina 6',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/r1.jpg'),
                      ),
                    ),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                    ),
                  ),
                  Text(
                    'Descripcion de la rutina 6',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: registros(args),
    );
  }

  Widget? registros(args) {
    return Padding(
      padding: const EdgeInsets.only(top: 88, left: 30),
      child: Align(
        alignment: Alignment.topLeft,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'record', arguments: args);
          },
          child: const Icon(Icons.library_books_outlined),
        ),
      ),
    );
  }
}
