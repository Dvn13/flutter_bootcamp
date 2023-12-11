import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/data/services/firebase_service.dart';

class AuthDaoRepository {
  FirebaseService firebaseService = FirebaseService();

  Future<User?> signUp(String email, String password) async {
    var result = await firebaseService.signUp(email, password);
    return result;
  }

  Future<User?> signIn(String email, String password) async {
    var result = await firebaseService.signIn(email, password);
    return result;
  }

  Future<void> signOut() async {
    await firebaseService.signOut();
  }
}
