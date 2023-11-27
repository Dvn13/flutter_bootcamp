import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odev7/data/repo/todo_dao_repository.dart';

class TodoAddCubit extends Cubit<void> {
  TodoAddCubit() : super(0);
  var todoRepo = TodosDaoRepository();

  Future<void> addTodo(String name) async {
    await todoRepo.addTodo(name);
  }
}
