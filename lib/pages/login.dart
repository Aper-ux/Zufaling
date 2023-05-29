import 'package:flutter/material.dart';
import '../classes/rutines.dart';
import '../classes/user.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({super.key});

  static String id = 'login';

  @override
  State<login> createState() => _loginState();
}

// ignore: camel_case_types
class _loginState extends State<login> {
  final user = TextEditingController();

  @override
  void initState() {
    super.initState();

    user.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    user.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${user.text}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('CordinAPP',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const Text('¿Quien eres?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 150,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nombre:',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: TextField(
                      controller: user,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      cursorHeight: 20,
                      cursorWidth: 2,
                      cursorRadius: const Radius.circular(1),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepOrange,
                          ),
                        ),
                        hintText: '',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () async {
                /* call to searchUser */
                final users = await searchUser(user.text);

                if (users.isEmpty) {
                  /* create user */
                  final userData = User(name: user.text);
                  await insertUser(userData);
                  rutinasPage(userData.name);
                  print('creo usuario');
                } else {
                  final userData = users[0].name;
                  rutinasPage(userData);
                  print('encontro usuario');
                  final Allusers = searchUsers();
                  printUsers(Allusers);
                  final Allrutines = printRutines();
                  //printAllRutines(Allrutines);
                }
              },
              child: const Text('Empezar'),
            ),
          ],
        ),
      ),
    ));
  }

  void printUsers(Allusers) async {
    Future<List<User>> usersFuture =
        Allusers; // Obtén el objeto Future<List<User>>

    usersFuture.then((List<User> users) {
      // El futuro se ha completado y se ha obtenido la lista de usuarios
      for (User user in users) {
        print('ID: ${user.id}, Name: ${user.name}');
      }
    });
  }

  void printAllRutines(Allrutines) async {
    Future<List<Rutines>> rutinesFuture =
        Allrutines; // Obtén el objeto Future<List<User>>

    rutinesFuture.then((List<Rutines> rutines) {
      for (Rutines rut in rutines) {
        print(
            'ID: ${rut.id}, Rutine: ${rut.rutine}, User: ${rut.userId}, Date: ${rut.date}, Completed: ${rut.completed}');
      }
    });
  }

  void rutinasPage(us) {
    showSnack(us);
    Navigator.pushNamed(context, 'rutinas', arguments: {'user': us});
  }

  void showSnack(us) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bienvenido $us !',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        duration: const Duration(seconds: 1),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
