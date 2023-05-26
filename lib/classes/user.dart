import 'package:sqflite/sqflite.dart';
import 'package:zufaling/database/data_base.dart';

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}

Future<void> insertUser(User user) async {
  // Obtiene una referencia de la base de datos
  final db = await data_base.instance.database;

  await db.insert(
    'user',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

/* search one user */
Future<List<User>> searchUser(String name) async {
  // Obtiene una referencia de la base de datos
  final db = await data_base.instance.database;

  // Consulta la tabla por todos los user.
  final List<Map<String, dynamic>> maps = await db.query('user',
      where: 'name = ?', whereArgs: [name], orderBy: 'name ASC');

  // Convierte List<Map<String, dynamic> en List<Dog>.
  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'].toString(),
      name: maps[i]['name'],
    );
  });
}
