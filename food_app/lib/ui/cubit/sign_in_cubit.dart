import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/repo/auth_dao_repository.dart';

class SignInCubit extends Cubit<int> {
  var authRepo = AuthDaoRepository();

  SignInCubit() : super(0);

  Future<User?> signIn(String email, String password) async {
    emit(1);
    try {
      var result = await authRepo.signIn(email, password);
      emit(0);
      return result;
    } catch (e) {
      emit(0);
      return null;
    }
  }
}
