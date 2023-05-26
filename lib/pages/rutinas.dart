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
            description: 'Descripcion rutina demo 1',
            bubles: Training.trainings['Facil']!,
            user: args['user'],
          ),
          RutinaWidgetButton(
            name: 'Rutina demo 2',
            description: 'Descripcion rutina demo 2',
            bubles: Training.trainings['Medio']!,
            user: args['user'],
          ),
          RutinaWidgetButton(
            name: 'Rutina demo 3',
            description: 'Descripcion rutina demo 3',
            bubles: Training.trainings['Dificil']!,
            user: args['user'],
          ),
          RutinaWidgetButton(
            name: 'Random demo',
            description: 'Descripcion rutina random demo',
            bubles: Training.getRandomBubles(Size(370.0, 370.0)),
            user: args['user'],
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
