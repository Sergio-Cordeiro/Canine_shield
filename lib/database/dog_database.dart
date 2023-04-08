import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:canine_shield/models/dog.dart';

class DogDatabase {
  static final DogDatabase _singleton = DogDatabase._internal();

  factory DogDatabase() {
    return _singleton;
  }

  DogDatabase._internal();

  static const String _databaseName = 'dogs.db';
  static const int _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT,
        age INTEGER,
        gender TEXT,
        castrated BOOLEAN
      )
    ''');
  }

  Future<void> insertDog(Dog dog) async {
    final db = await database;

    await db.insert(
      'dogs',
      {'name': dog.name, 'breed': dog.breed, 'age': dog.age, 'gender': dog.gender, 'castrated': dog.castrated},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Dog>> dogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');

    return maps.fold<List<Dog>>([], (dogs, map) {
      try {
        final dog = Dog.toDog(map);
        dogs.add(dog);
      } catch (e) {
        print('Erro ao converter os dados do banco de dados em um objeto Dog: $e');
      }
      return dogs;
    });
  }

  Future<void> deleteDog(int id) async {
    final db = await database;

    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateDog(Dog dog) async {
    final db = await database;

    await db.update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
  }

}