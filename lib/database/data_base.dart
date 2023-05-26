import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

// ignore: camel_case_types
class data_base {
  static final data_base instance = data_base._init();

  static Database? _database;

  data_base._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cordinapp.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
  ''');

    await db.execute('''
    CREATE TABLE rutine (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      rutine INTEGER NOT NULL,
      date TEXT NOT NULL,
      completed TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES user(id)
    )
  ''');
  }
}
