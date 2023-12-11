import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app/data/entity/order_model.dart';

class FirebaseService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  FirebaseService();

  /// Firebase Auth
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  String? getUserUid() {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        return user.uid;
      } else {
        return null;
      }
    } catch (e) {
      print("Hata: $e");
      return null;
    }
  }

  Stream<User?> get user {
    return auth.authStateChanges();
  }

  /// Fire Store

  Stream<List<String>> getFavoriteFoods() {
    return _usersCollection
        .doc(getUserUid())
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  Future<void> addFavoriteFood(String foodID) async {
    try {
      await _usersCollection
          .doc(getUserUid())
          .collection('favorites')
          .doc(foodID)
          .set({'isFavorite': true});
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }
    }
  }

  Future<void> removeFavoriteFood(String foodID) async {
    try {
      await _usersCollection
          .doc(getUserUid())
          .collection('favorites')
          .doc(foodID)
          .delete();
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  Future<void> addOrders(List<OrderModel> orders) async {
    try {
      await _usersCollection.doc(getUserUid()).collection('orders').add({
        'orderList': orders.map((order) => order.toJson()).toList(),
        'orderDate': DateTime.now(),
      });
    } catch (e) {
      if (kDebugMode) {
        print('Hata oluştu: $e');
      }
    }
  }

  Stream<List<OrderListModel>> getOrderHistory() {
    return _usersCollection
        .doc(getUserUid())
        .collection('orders')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              Map<String, dynamic> data = doc.data();
              List<Map<String, dynamic>> orderListData =
                  List<Map<String, dynamic>>.from(data['orderList'] ?? []);
              List<OrderModel> orderList = orderListData
                  .map((order) => OrderModel.fromJson(order))
                  .toList();
              DateTime orderDate = (data['orderDate'] as Timestamp).toDate();

              return OrderListModel(orderList: orderList, orderDate: orderDate);
            }).toList());
  }
}
