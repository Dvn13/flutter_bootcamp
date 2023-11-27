import 'package:odev7/data/entity/todo_model.dart';
import 'package:odev7/sqlite/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class TodosDaoRepository {
  static const String tableName = 'todo';

  Future<Database> _getDatabase() async {
    return await DbConnection.databaseAccess();
  }

  Future<List<TodoModel>> getTodo() async {
    var db = await _getDatabase();
    List<Map<String, dynamic>> todoList = await db.query(tableName);

    return List.generate(todoList.length, (index) {
      var item = todoList[index];
      var id = item['id'] as int;
      var name = item['name'] as String;

      return TodoModel(id: id, name: name);
    });
  }

  Future<void> addTodo(String name) async {
    var db = await _getDatabase();

    var todo = <String, dynamic>{'name': name};
    await db.insert(tableName, todo);
  }

  Future<void> updateTodo(int id, String name) async {
    var db = await _getDatabase();

    var updatedTodo = <String, dynamic>{'name': name};
    await db.update(tableName, updatedTodo, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteTodo(int id) async {
    var db = await _getDatabase();

    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TodoModel>> searchTodo(String searchText) async {
    var db = await _getDatabase();
    List<Map<String, dynamic>> todoList = await db
        .rawQuery("SELECT * FROM $tableName WHERE name LIKE ('%$searchText%')");

    return List.generate(todoList.length, (index) {
      var item = todoList[index];
      var id = item['id'] as int;
      var name = item['name'] as String;

      return TodoModel(id: id, name: name);
    });
  }
}
