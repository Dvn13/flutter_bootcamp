import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/const/color.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';
import 'package:food_app/data/entity/foods_model.dart';
import 'package:food_app/data/services/path.dart';
import 'package:food_app/ui/cubit/food_crud_cubit.dart';
import 'package:food_app/ui/views/detail_food_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class FoodCard extends StatefulWidget {
  final Yemekler food;
  final FoodCartPostModel foodCartPostModel;
  const FoodCard({super.key, required this.food, required this.foodCartPostModel});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailFood(food: widget.food)));
      },
      child: Card(
        elevation: 0,
        color: ConstColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  foodImage(widget.food),
                  const SizedBox(height: 8),
                  foodContent(widget.food),
                  const SizedBox(height: 4),
                  addCartButton(widget.food)
                ],
              ),
              StreamBuilder<List<String>>(
                stream: context
                    .read<FoodCrudCubit>()
                    .getFavoriteFoods(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ConstColor.primary,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Icon(
                      Icons.error,
                      color: ConstColor.red,
                    );
                  } else {
                    var favoriteList = snapshot.data;
                    var isFavorite = favoriteList!.contains(widget.food.yemekId);
                    return InkWell(
                      onTap: () async {
                        if (isFavorite) {
                          await context
                              .read<FoodCrudCubit>()
                              .removeFavoriteFood(widget.food.yemekId.toString());
                        } else {
                          await context
                              .read<FoodCrudCubit>()
                              .addFavoriteFood(widget.food.yemekId.toString());
                        }
                      },
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline_rounded,
                        color: ConstColor.white,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget foodImage(Yemekler food) {
    return Hero(
      tag: food.yemekResimAdi!,
      child: Image.network(
        NetworkRoute.imgPath + food.yemekResimAdi!,
        width: 75,
        height: 75,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget foodContent(Yemekler food) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '${food.yemekAdi}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
            maxLines: 2,
          ),
        ),
        Text(
          '₺${food.yemekFiyat}',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }

  Widget addCartButton(Yemekler food) {
    return BlocBuilder<FoodCrudCubit, FoodCrudCubitState>(
      builder: (context, state) {
        if (state is AddCartLoadingState && state.loading == 1) {
          return food.yemekAdi == widget.foodCartPostModel.yemekAdi
              ? const CircularProgressIndicator()
              : addCardIcon();
        }
        return InkWell(
          onTap: () async {
            await _addToCart(context, food);
          },
          child: addCardIcon(),
        );
      },
    );
  }

  Card addCardIcon() {
    return const Card(
      margin: EdgeInsets.all(0),
      child: Center(
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addToCart(BuildContext context, Yemekler food) async {
    widget.foodCartPostModel.yemekAdi = food.yemekAdi;
    widget.foodCartPostModel.yemekFiyat = int.parse(food.yemekFiyat!);
    widget.foodCartPostModel.yemekResimAdi = food.yemekResimAdi;
    widget.foodCartPostModel.yemekSiparisAdet = 1;
    if (!mounted) return;
    var result = await context.read<FoodCrudCubit>().addCart(widget.foodCartPostModel);
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
}
