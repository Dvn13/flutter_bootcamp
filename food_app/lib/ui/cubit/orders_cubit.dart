import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/order_model.dart';
import 'package:food_app/data/repo/orders_dao_repository.dart';

class OrdersCubit extends Cubit<int> {
  OrdersCubit() : super(0);

  var ordersDaoRepository = OrdersDaoRepository();

  Stream<List<OrderListModel>> getOrderHistory() {
    return ordersDaoRepository.getOrderHistory();
  }

  Future<void> addOrders(List<OrderModel> orders) async {
    await ordersDaoRepository.addOrders(orders);
  }
}
