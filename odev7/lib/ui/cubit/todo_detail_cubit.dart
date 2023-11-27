import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odev7/data/repo/todo_dao_repository.dart';

class TodoDetaiCubit extends Cubit<void> {
  TodoDetaiCubit() : super(0);
  var todoRepo = TodosDaoRepository();

  Future<void> updateTodo(int id, String name) async {
    await todoRepo.updateTodo(id, name);
  }
}
