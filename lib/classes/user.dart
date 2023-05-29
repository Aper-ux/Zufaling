import 'package:sqflite/sqflite.dart';
import 'package:zufaling/database/data_base.dart';

class User {
  int? id;

  final String name;

  User({this.id, required this.name}); // Permitir que el campo id sea opcional

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Puede ser null si no se proporciona al crear la instancia
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
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}

/* search all users */
Future<List<User>> searchUsers() async {
  final db = await data_base.instance.database;

  final List<Map<String, dynamic>> maps = await db.query('user');

  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      name: maps[i]['name'],
    );
  });
}
