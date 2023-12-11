import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/data/entity/foods_model.dart';
import 'package:food_app/data/services/path.dart';
import 'package:food_app/ui/cubit/detail_page_cubit.dart';
import 'package:food_app/ui/cubit/food_crud_cubit.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class DetailFood extends StatefulWidget {
  Yemekler food;
  DetailFood({super.key, required this.food});

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  @override
  void initState() {
    super.initState();
    var detailFoodCubit = context.read<DetailFoodCubit>();

    detailFoodCubit.foodCartPostModel.yemekAdi = widget.food.yemekAdi;
    detailFoodCubit.foodCartPostModel.yemekFiyat =
        int.parse(widget.food.yemekFiyat!);
    detailFoodCubit.foodCartPostModel.yemekResimAdi = widget.food.yemekResimAdi;
    detailFoodCubit.foodCartPostModel.yemekSiparisAdet = detailFoodCubit.state;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var detailFoodCubit = context.read<DetailFoodCubit>();
    detailFoodCubit.resetFoodCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.primary,
      body: Padding(
        padding: MediaQuery.of(context).padding,
        child: Stack(
          children: [
            Column(
              children: [
                buildImage(),
                buildContent(),
              ],
            ),
            backPage(context),
          ],
        ),
      ),
    );
  }

  Expanded buildImage() {
    return Expanded(
      flex: 1,
      child: Container(
        color: ConstColor.primary,
        child: foodImageWidget(),
      ),
    );
  }

  Expanded buildContent() {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(80),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 40, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ratingWidget(),
                  foodPriceWidget(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    foodNameWidget(),
                    foodCountWidget(),
                  ],
                ),
              ),
              addCart()
            ],
          ),
        ),
      ),
    );
  }

  Text foodNameWidget() {
    return Text(
      '${widget.food.yemekAdi}',
      style: const TextStyle(fontSize: 26, color: ConstColor.black),
    );
  }

  Widget foodCountWidget() {
    var detailFoodCubit = context.read<DetailFoodCubit>();
    detailFoodCubit.updateFoodCount(1);
    return BlocBuilder<DetailFoodCubit, int>(
      builder: (context, currentCount) {
        return Row(
          children: [
            CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  context.read<DetailFoodCubit>().updateFoodCount(-1);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                currentCount.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  context.read<DetailFoodCubit>().updateFoodCount(1);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget addCart() {
    return BlocBuilder<FoodCrudCubit, FoodCrudCubitState>(
        builder: (context, state) {
      if (state is AddCartLoadingState && state.loading == 1) {
        return const CircularProgressIndicator();
      }
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  await _addToCart(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ConstColor.primary),
                child: const Text(
                  'Sepete Ekle',
                  style: TextStyle(color: Colors.white),
                ))),
      );
    });
  }

  Future<void> _addToCart(BuildContext context) async {
    var model = context.read<DetailFoodCubit>().foodCartPostModel;
    var result = await context.read<FoodCrudCubit>().addCart(model);
    if (result.success == 0) {
      if (!mounted) return;
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Ürün Sepete Eklenemedi.',
      );
    } else {
      if (!mounted) return;
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        confirmBtnText: 'Tamam',
        title: 'Başarılı',
        text: 'Ürün Sepete Eklendi.',
      );
    }
  }

  Container ratingWidget() {
    double randomDouble = Random().nextDouble() * 5;
    randomDouble = double.parse(randomDouble.toStringAsFixed(1));
    return Container(
      decoration: BoxDecoration(
        color: ConstColor.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 20,
            color: ConstColor.orange,
          ),
          const SizedBox(width: 5),
          Text(
            randomDouble.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18 * 0.8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Text foodPriceWidget() {
    return Text(
      '${widget.food.yemekFiyat}₺',
      style: const TextStyle(fontSize: 26, color: ConstColor.red),
    );
  }

  Positioned backPage(BuildContext context) {
    return Positioned(
      left: 10,
      top: 10,
      child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          )),
    );
  }

  Hero foodImageWidget() {
    return Hero(
      tag: widget.food.yemekResimAdi!,
      child: Image.network(
        NetworkRoute.imgPath + widget.food.yemekResimAdi!,
        fit: BoxFit.cover,
      ),
    );
  }
}
