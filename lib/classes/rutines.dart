import 'package:sqflite/sqflite.dart';
import 'package:zufaling/database/data_base.dart';

class Rutines {
  final int? id;
  final String rutine;
  final int? userId;
  final String date;
  final String completed;

  Rutines(
      {this.id,
      required this.userId,
      required this.rutine,
      required this.date,
      required this.completed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'rutine': rutine,
      'date': date,
      'completed': completed,
    };
  }

  /* toString */
  @override
  String toString() {
    return 'Rutines{id: $id, userId: $userId, rutine: $rutine, date: $date, completed: $completed}';
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

/* Print all rutines */
Future<List<Rutines>> printRutines() async {
  final db = await data_base.instance.database;

  final List<Map<String, dynamic>> maps = await db.query('rutine');

  return List.generate(maps.length, (i) {
    return Rutines(
      id: maps[i]['id'],
      userId: maps[i]['user_id'],
      rutine: maps[i]['rutine'],
      date: maps[i]['date'],
      completed: maps[i]['completed'],
    );
  });
}
