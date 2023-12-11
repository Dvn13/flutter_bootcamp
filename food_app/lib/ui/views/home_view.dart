import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';
import 'package:food_app/data/entity/foods_model.dart';
import 'package:food_app/ui/_widget/food_card.dart';
import 'package:food_app/ui/_widget/search_widget.dart';
import 'package:food_app/ui/cubit/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FoodCartPostModel foodCartPostModel = FoodCartPostModel();
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleWidget(),
          searchWidget(context),
          foodMenuListView(),
        ],
      ),
    );
  }

  Text titleWidget() {
    return const Text(
      'Menü',
      style: TextStyle(fontSize: 30),
    );
  }

  Padding searchWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SearchWidget(
        onChanged: (p0) => context.read<HomeCubit>().search(p0),
      ),
    );
  }

  Widget foodMenuListView() {
    return BlocBuilder<HomeCubit, List<Yemekler>>(
        builder: (context, foodsList) {
      if (foodsList.isNotEmpty) {
        return Expanded(
          child: GridView.builder(
            itemCount: foodsList.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 0.70),
            itemBuilder: (BuildContext context, int index) {
              var food = foodsList[index];
              return FoodCard(food: food, foodCartPostModel: foodCartPostModel);
            },
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
