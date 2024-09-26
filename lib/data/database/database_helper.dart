import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    print('Creating users table...');
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT
      )
    ''');
    print('Users table created.');

    print('Creating messages table...');
    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        message TEXT
      )
    ''');
    print('Messages table created.');
  }

  Future<void> registerUser(String username, String password) async {
    final db = await database;
    await db.insert('users', {'username': username, 'password': password});
    print('User $username registered successfully.');
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      print('User $username found in the database.');
      return result.first;
    } else {
      print('User $username not found.');
      return null;
    }
  }

  Future<void> insertMessage(String message) async {
    final db = await database;
    await db.insert('messages', {'message': message});
    print('Message inserted: $message');
  }

  Future<List<String>> getMessages() async {
    final db = await database;
    final result = await db.query('messages');
    print('Messages retrieved from database.');
    return result.map((e) => e['message'] as String).toList();
  }
}
