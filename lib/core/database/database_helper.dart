import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'logishield.db');

    return openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createParcelsTable(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS shipments');

      await db.execute('DROP TABLE IF EXISTS parcels');

      await _createParcelsTable(db);
    }
  }

  Future<void> _createParcelsTable(Database db) async {
    await db.execute('''
      CREATE TABLE parcels(
        id TEXT PRIMARY KEY,
        trackingId TEXT NOT NULL,
        carrier TEXT NOT NULL,
        customerName TEXT NOT NULL,
        phone TEXT NOT NULL,
        address TEXT NOT NULL,
        codAmount REAL NOT NULL,
        status TEXT NOT NULL,
        lastUpdated TEXT NOT NULL,
        isDelayed INTEGER NOT NULL
      )
    ''');
  }
}
