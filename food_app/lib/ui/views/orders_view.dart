import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';
import 'package:food_app/data/entity/order_model.dart';
import 'package:food_app/data/services/path.dart';
import 'package:food_app/ui/_widget/custom_button.dart';
import 'package:food_app/ui/cubit/food_crud_cubit.dart';
import 'package:food_app/ui/cubit/navbar_cubit.dart';
import 'package:food_app/ui/cubit/orders_cubit.dart';
import 'package:food_app/ui/views/navbar_view.dart';
import 'package:food_app/ui/views/orders_detail_view.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(context),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ConstColor.primary,
      iconTheme: const IconThemeData(color: ConstColor.white),
      title: const Text(
        'Geçmiş Siparişlerim',
        style: TextStyle(color: ConstColor.white),
      ),
    );
  }

  Widget body(BuildContext context) {
    return StreamBuilder<List<OrderListModel>>(
      stream: context.read<OrdersCubit>().getOrderHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return const Center(
            child: Text('Veri alınamadı!'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Sipariş bulunamadı.'),
          );
        } else {
          var list = snapshot.data!;
          var reversedList = list.reversed;
          return Column(
            children: [
              ordersListView(reversedList.toList()),
            ],
          );
        }
      },
    );
  }

  ListView ordersListView(List<OrderListModel> list) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final order = list[index];
        String timestampString = order.orderDate.toString();

        DateTime dateTime = DateTime.parse(timestampString);
        String formattedDate =
            '${dateTime.day}-${dateTime.month}-${dateTime.year}';
        String formattedTime = '${dateTime.hour}:${dateTime.minute}';
        double totalOrderPrice = 0;
        for (var element in order.orderList!) {
          totalOrderPrice += double.parse(element.totalPrice);
        }

        return listItem(
            context, order, totalOrderPrice, formattedDate, formattedTime);
      },
    );
  }

  InkWell listItem(BuildContext context, OrderListModel order,
      double totalOrderPrice, String formattedDate, String formattedTime) {
    return InkWell(
      onTap: () {
        goToOrdersDetail(context, order, totalOrderPrice);
      },
      child: Card(
        color: ConstColor.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ordersInfo(formattedDate, formattedTime, totalOrderPrice),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ordersImageList(order),
                  InkWell(
                    onTap: () async {
                      await _tryOrders(order, context);
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.refresh_outlined),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _tryOrders(OrderListModel order, BuildContext context) async {
    var foodCartPostModel = FoodCartPostModel();
    for (var food in order.orderList!) {
      foodCartPostModel.yemekAdi = food.foodName;
      foodCartPostModel.yemekFiyat = int.parse(food.foodPrice);
      foodCartPostModel.yemekSiparisAdet = int.parse(food.foodQuantity);
      foodCartPostModel.yemekResimAdi = food.foodImage;
      await context.read<FoodCrudCubit>().addCart(foodCartPostModel);
    }

    context.read<NavbarCubit>().updateNavigation(2);
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const NavbarView()),
        (Route<dynamic> route) => false);
  }

  Row ordersInfo(
      String formattedDate, String formattedTime, double totalOrderPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$formattedDate $formattedTime',
          style: const TextStyle(color: ConstColor.white),
        ),
        Text(
          '$totalOrderPrice₺',
          style: const TextStyle(color: ConstColor.white),
        ),
      ],
    );
  }

  SizedBox ordersImageList(OrderListModel order) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: order.orderList!.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var orderListCount = order.orderList!.length;
          if (index < 4) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CircleAvatar(
                radius: 25,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: index != 3
                      ? Image.network(
                          NetworkRoute.imgPath +
                              order.orderList![index].foodImage,
                          fit: BoxFit.contain,
                          height: 85,
                        )
                      : Text('+${orderListCount - 3}'),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void goToOrdersDetail(
      BuildContext context, OrderListModel order, double totalOrderPrice) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OrdersDetailView(
                  orderList: order.orderList ?? [],
                  totalOrderPrice: totalOrderPrice,
                )));
  }
}
