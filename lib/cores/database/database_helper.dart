import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "rhome.db";
  static const _databaseVersion = 1;

  static const buttonTable = 'buttons';
  static const ipTable = 'ipAddress';

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = await getDatabasesPath() + _databaseName;
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $buttonTable (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      image TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE $ipTable (
      id INTEGER PRIMARY KEY,
      ipAddress TEXT NOT NULL
    )
    ''');
  }
}
