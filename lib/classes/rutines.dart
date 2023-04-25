import 'package:sqflite/sqflite.dart';
import 'package:zufaling/database/data_base.dart';

class Rutines {
  final int id;
  final String rutine;
  final String userId;
  final String date;

  Rutines(
      {required this.id,
      required this.userId,
      required this.rutine,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': userId,
      'rutine': rutine,
      'date': date,
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
