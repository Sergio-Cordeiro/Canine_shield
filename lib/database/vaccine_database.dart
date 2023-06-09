import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/vaccine.dart';

class VaccineDatabase {
  static final VaccineDatabase instance = VaccineDatabase._init();

  static Database? _database;

  VaccineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('vaccine.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE vaccines (
        id TEXT PRIMARY KEY,
        name TEXT,
        dateActually TEXT,
        dateNextVaccine TEXT,
        dog_id INTEGER,
        FOREIGN KEY(dog_id) REFERENCES dogs(id) ON DELETE CASCADE
      )
    ''');
  }

  Future<Vaccine> createVaccine(Vaccine vaccine) async {
    final db = await instance.database;
    final id = await db.insert('vaccines', vaccine.toJson());
    return vaccine.copy(id: id.toString());
  }

  Future<List<Vaccine>> getVaccines(int dogId) async {
    final db = await instance.database;
    final maps = await db.query('vaccines', where: 'dog_id = ?', whereArgs: [dogId]);

    return List.generate(maps.length, (i) {
      return Vaccine(
        id: maps[i]['id'] as String,
        name: maps[i]['name'] as String,
        dateActually: maps[i]['dateActually'].toString(),
        dateNextVaccine: maps[i]['dateNextVaccine'].toString(),
        dogId: int.parse(maps[i]['dog_id'].toString()),
      );
    });
  }

  Future<List<Vaccine>> getVaccinesByDogId(int dogId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('vaccines', where: 'dog_id = ?', whereArgs: [dogId]);

    return List.generate(maps.length, (i) {
      return Vaccine.fromJson(maps[i]);
    });
  }

}
