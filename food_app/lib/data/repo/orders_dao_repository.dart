import 'package:food_app/data/entity/order_model.dart';
import 'package:food_app/data/services/firebase_service.dart';

class OrdersDaoRepository {
  FirebaseService firebaseService = FirebaseService();

  Future<void> addOrders(List<OrderModel> orders) async {
    await firebaseService.addOrders(orders);
  }

  Stream<List<OrderListModel>> getOrderHistory() {
    return firebaseService.getOrderHistory();
  }
}
