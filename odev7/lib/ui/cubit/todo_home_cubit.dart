import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odev7/data/entity/todo_model.dart';
import 'package:odev7/data/repo/todo_dao_repository.dart';

class TodoHomeCubit extends Cubit<List<TodoModel>> {
  TodoHomeCubit() : super(<TodoModel>[]);
  var todoRepo = TodosDaoRepository();

  Future<void> getTodo() async {
    var liste = await todoRepo.getTodo();
    emit(liste);
  }

  Future<void> searchTodo(String searchText) async {
    var liste = await todoRepo.searchTodo(searchText);
    emit(liste);
  }

  Future<void> deleteTodo(int todoId) async {
    await todoRepo.deleteTodo(todoId);
    getTodo();
  }
}
