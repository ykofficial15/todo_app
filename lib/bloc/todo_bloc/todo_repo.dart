import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoRepo {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE todos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    isCompleted INTEGER,
    createdAt TEXT
  )''');
      },
    );
  }

  Future<int> insertTodo(
    String title,
    String description,
    DateTime date,
  ) async {
    final db = await database;
    return await db.insert('todos', {
      'title': title,
      'description': description,
      'isCompleted': 0,
      'createdAt': date.toIso8601String(),
    });
  }

  Future<int> updateTodo(
    int id,
    String title,
    String description,
    int isCompleted,
  ) async {
    final db = await database;
    return await db.update(
      'todos',
      {'title': title, 'description': description, 'isCompleted': isCompleted},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete('todos', where: 'id=?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getTodosByDate(DateTime date) async {
    _db = await _initDb();
    final db = await database;
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    return await db.query(
      'todos',
      where: 'createdAt >= ? AND createdAt < ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
    );
  }
}
