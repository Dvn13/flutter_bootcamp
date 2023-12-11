import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';
import 'package:food_app/data/entity/foods_model.dart';
import 'package:food_app/ui/_widget/food_card.dart';
import 'package:food_app/ui/cubit/food_crud_cubit.dart';
import 'package:food_app/ui/cubit/home_cubit.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  FoodCartPostModel foodCartPostModel = FoodCartPostModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favori Ürünler'),
      ),
      body: body(),
    );
  }

  StreamBuilder<List<String>> body() {
    return StreamBuilder<List<String>>(
      stream: context.read<FoodCrudCubit>().getFavoriteFoods(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: ConstColor.primary,
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Veri alınamadı!'),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Favori ürün bulunamadı.'),
          );
        } else {
          var foodList = context.read<HomeCubit>().foodsList;
          var favoriteIDs = snapshot.data!;
          var filteredFoods = foodList
              .where((food) => favoriteIDs.contains(food.yemekId.toString()))
              .toList();
          return favoriteList(filteredFoods);
        }
      },
    );
  }

  Widget favoriteList(List<Yemekler> list) {
    return GridView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.70),
      itemBuilder: (BuildContext context, int index) {
        var food = list[index];
        return FoodCard(food: food, foodCartPostModel: foodCartPostModel);
      },
    );
  }
}
