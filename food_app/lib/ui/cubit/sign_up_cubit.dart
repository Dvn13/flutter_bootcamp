import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/repo/auth_dao_repository.dart';

class SignUpCubit extends Cubit<int> {
  var authRepo = AuthDaoRepository();

  SignUpCubit() : super(0);

  Future<User?> signUp(String email, String password) async {
    emit(1);
    try {
      var result = await authRepo.signUp(email, password);
      emit(0);
      return result;
    } catch (e) {
      emit(0);
      return null;
    }
  }
}
