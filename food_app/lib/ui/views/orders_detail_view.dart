import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';
import 'package:food_app/data/entity/order_model.dart';
import 'package:food_app/ui/_widget/custom_button.dart';
import 'package:food_app/ui/cubit/food_crud_cubit.dart';
import 'package:food_app/ui/cubit/navbar_cubit.dart';
import 'package:food_app/ui/views/navbar_view.dart';

class OrdersDetailView extends StatefulWidget {
  final List<OrderModel> orderList;
  final double totalOrderPrice;
  const OrdersDetailView(
      {super.key, required this.orderList, required this.totalOrderPrice});

  @override
  State<OrdersDetailView> createState() => _OrdersDetailViewState();
}

class _OrdersDetailViewState extends State<OrdersDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [orderListView(), orderTotal(), tryOrder()],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Sipariş Detayı'),
    );
  }

  Expanded orderListView() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.orderList.length,
        itemBuilder: (context, index) {
          var orderListItem = widget.orderList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: orderDetails(orderListItem),
          );
        },
      ),
    );
  }

  Padding tryOrder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          BlocBuilder<FoodCrudCubit, FoodCrudCubitState>(
              builder: (context, state) {
            if (state is AddCartLoadingState && state.loading == 1) {
              return const CircularProgressIndicator();
            }
            return button(context);
          })
        ],
      ),
    );
  }

  CustomButton button(BuildContext context) {
    return CustomButton(
      width: double.infinity,
      buttonText: 'Siparişi Tekrarla',
      onPressed: () async {
        var foodCartPostModel = FoodCartPostModel();
        for (var food in widget.orderList) {
          foodCartPostModel.yemekAdi = food.foodName;
          foodCartPostModel.yemekFiyat = int.parse(food.foodPrice);
          foodCartPostModel.yemekSiparisAdet = int.parse(food.foodQuantity);
          foodCartPostModel.yemekResimAdi = food.foodImage;
          await context.read<FoodCrudCubit>().addCart(foodCartPostModel);
        }
        if (!mounted) return;
        context.read<NavbarCubit>().updateNavigation(2);
        await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const NavbarView()),
            (Route<dynamic> route) => false);
      },
    );
  }

  Padding orderTotal() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Sipariş Tutarı',
            style: TextStyle(
                color: ConstColor.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '${widget.totalOrderPrice}₺',
            style: const TextStyle(
                color: ConstColor.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget orderDetails(OrderModel orderListItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'x${orderListItem.foodQuantity}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: ConstColor.black),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              orderListItem.foodName,
              style: const TextStyle(color: ConstColor.black),
            ),
          ],
        ),
        Text(
          '${orderListItem.totalPrice}₺',
          style: const TextStyle(color: ConstColor.black),
        ),
      ],
    );
  }
}
