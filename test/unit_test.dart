import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/bloc/todo_bloc/todo_repo.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('Insert, Get and Delete todo', () async {
    final repo = TodoRepo();
    final db = await repo.database;

    await db.delete('todos');

    final id1 = await repo.insertTodo('Test 1', 'Desc 1', DateTime.now());
    await repo.insertTodo('Test 2', 'Desc 2', DateTime.now());
    await repo.insertTodo('Test 3', 'Desc 3', DateTime.now());
    await repo.insertTodo('Test 4', 'Desc 4', DateTime.now());

    var result = await repo.getTodosByDate(DateTime.now());
    expect(result.length, 4);

    await repo.deleteTodo(id1);

    result = await repo.getTodosByDate(DateTime.now());
    expect(result.length, 3);

    final deletedTodo = result.where((t) => t['id'] == id1).toList();
    expect(deletedTodo.isEmpty, true);
  });
}
