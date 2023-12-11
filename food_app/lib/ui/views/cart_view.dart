import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/data/entity/order_model.dart';
import 'package:food_app/data/services/path.dart';
import 'package:food_app/ui/_widget/custom_button.dart';
import 'package:food_app/ui/cubit/food_crud_cubit.dart';
import 'package:food_app/ui/cubit/orders_cubit.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    context.read<FoodCrudCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCrudCubit, FoodCrudCubitState>(
      builder: (context, state) {
        var groupedFoodList = context.watch<FoodCrudCubit>().groupedFoodList;
        var totalCartPrice = context.watch<FoodCrudCubit>().totalCartPrice;
        if (state is GetCartLoadingState && state.loading == 1) {
          return const Center(child: CircularProgressIndicator());
        }
        if (groupedFoodList.isNotEmpty) {
          return Column(
            children: [
              cartListWidget(groupedFoodList),
              addOrderWidget(totalCartPrice, context, groupedFoodList)
            ],
          );
        } else {
          return const Center(child: Text('Sepet Boş'));
        }
      },
    );
  }

  Padding addOrderWidget(double totalCartPrice, BuildContext context,
      List<dynamic> groupedFoodList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            ('Toplam Tutar: ${totalCartPrice.toString()}₺'),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )),
          Expanded(
            child: CustomButton(
                buttonText: 'Siparişi Onayla',
                onPressed: () {
                  addOrderDialog(context, groupedFoodList);
                }),
          ),
        ],
      ),
    );
  }

  void addOrderDialog(BuildContext context, List<dynamic> groupedFoodList) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      showCancelBtn: true,
      confirmBtnText: 'Evet',
      cancelBtnText: 'Hayır',
      text: 'Siparişi Onaylıyor musunuz?',
      onConfirmBtnTap: () async {
        List<OrderModel> orderList = [];
        for (var element in groupedFoodList) {
          orderList.add(OrderModel(
            foodName: element['yemek_adi'],
            foodImage: element['yemek_resim_adi'],
            foodQuantity: element['yemek_siparis_adet'].toString(),
            foodPrice: element['yemek_fiyat'].toString(),
            totalPrice: element['total_price'].toString(),
          ));
        }

        await context.read<OrdersCubit>().addOrders(orderList);
        for (var foods in groupedFoodList) {
          List idList = foods['sepet_yemek_id'];
          if (!mounted) return;
          await context.read<FoodCrudCubit>().deleteFoodCart(idList);
        }
        if (!mounted) return;
        Navigator.of(context).pop();
      },
    );
  }

  Widget cartListWidget(List<dynamic> groupedFoodList) {
    return Expanded(
      child: ListView.builder(
        itemCount: groupedFoodList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var food = groupedFoodList[index];
          return Column(
            children: [
              cartCardWidget(food),
            ],
          );
        },
      ),
    );
  }

  Widget cartCardWidget(food) {
    return Card(
      elevation: 0,
      color: ConstColor.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cardLeft(food),
            cardCenter(food),
            cardright(food),
          ],
        ),
      ),
    );
  }

  Image cardLeft(food) {
    return Image.network(
      NetworkRoute.imgPath + food['yemek_resim_adi'],
      fit: BoxFit.cover,
      height: 85,
    );
  }

  Expanded cardCenter(food) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              food['yemek_adi'],
              style: const TextStyle(
                  color: ConstColor.white, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Text(
                  ('Fiyat: '),
                  style: TextStyle(
                    color: ConstColor.white,
                  ),
                ),
                Text(
                  ('${food['yemek_fiyat']}₺'),
                  style: const TextStyle(
                    color: ConstColor.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  ('Adet: '),
                  style: TextStyle(
                    color: ConstColor.white,
                  ),
                ),
                Text(
                  (food['yemek_siparis_adet'].toString()),
                  style: const TextStyle(
                    color: ConstColor.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column cardright(food) {
    return Column(
      children: [
        Text(
          ('Toplam: ${food['total_price']}₺'),
          style: const TextStyle(
              color: ConstColor.white, fontWeight: FontWeight.bold),
        ),
        IconButton(
            onPressed: () async {
              List list = food['sepet_yemek_id'];
              await context.read<FoodCrudCubit>().deleteFoodCart(list);
            },
            icon: const Icon(
              Icons.delete,
              color: ConstColor.white,
            )),
      ],
    );
  }
}
