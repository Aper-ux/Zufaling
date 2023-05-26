import 'package:sqflite/sqflite.dart';
import 'package:zufaling/database/data_base.dart';

class Rutines {
  final int id;
  final String rutine;
  final String userId;
  final String date;
  final String completed;

  Rutines(
      {required this.id,
      required this.userId,
      required this.rutine,
      required this.date,
      required this.completed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': userId,
      'rutine': rutine,
      'date': date,
      'completed': completed,
    };
  }
}

Future<void> insertRutine(Rutines rutine) async {
  // Obtiene una referencia de la base de datos
  final db = await data_base.instance.database;

  await db.insert(
    'rutine',
    rutine.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Map<String, dynamic>>> searchRutines(String user) async {
  final db = await data_base.instance.database;

  //Get the rutines list for the user
  final List<Map<String, dynamic>> maps = await db.query('rutine',
      where: 'user_id = ?', whereArgs: [user], orderBy: 'id ASC');

  /* return rutines list */
  return maps;
}
