class OrderListModel {
  List<OrderModel>? orderList;
  DateTime? orderDate;

  OrderListModel({this.orderList, this.orderDate});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    if (json['orderList'] != null) {
      orderList = <OrderModel>[];
      json['orderList'].forEach((v) {
        orderList!.add(OrderModel.fromJson(v));
      });
    }
    orderDate = json['orderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderList != null) {
      data['orderList'] = orderList!.map((v) => v.toJson()).toList();
    }
    data['orderDate'] = orderDate;
    return data;
  }
}

class OrderModel {
  final String foodName;
  final String foodImage;
  final String foodQuantity;
  final String foodPrice;
  final String totalPrice;

  OrderModel({
    required this.foodName,
    required this.foodImage,
    required this.foodQuantity,
    required this.foodPrice,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'foodName': foodName,
      'foodImage': foodImage,
      'foodQuantity': foodQuantity,
      'foodPrice': foodPrice,
      'totalPrice': totalPrice,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      foodName: json['foodName'],
      foodImage: json['foodImage'],
      foodQuantity: json['foodQuantity'],
      foodPrice: json['foodPrice'],
      totalPrice: json['totalPrice'],
    );
  }
}
