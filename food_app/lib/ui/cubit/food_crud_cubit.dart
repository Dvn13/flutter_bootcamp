import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/foods_cart_model.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';
import 'package:food_app/data/entity/result_model.dart';
import 'package:food_app/data/repo/foods_dao_repository.dart';
import 'package:food_app/data/services/firebase_service.dart';

abstract class FoodCrudCubitState {}

class InitialState extends FoodCrudCubitState {
  InitialState();
}

class AddCartLoadingState extends FoodCrudCubitState {
  final int loading;

  AddCartLoadingState(this.loading);
}

class GetCartLoadingState extends FoodCrudCubitState {
  final int loading;

  GetCartLoadingState(this.loading);
}

class DeleteFoodCartLoadingState extends FoodCrudCubitState {
  final int loading;

  DeleteFoodCartLoadingState(this.loading);
}

class FoodCrudCubit extends Cubit<FoodCrudCubitState> {
  FoodCrudCubit() : super(InitialState());

  FoodsDaoRepository foodsRepo = FoodsDaoRepository();
  FirebaseService firebaseService = FirebaseService();
  FoodCartModel foodCartModel = FoodCartModel();
  List<dynamic> groupedFoodList = [];
  double totalCartPrice = 0;

  Future<ResultModel> addCart(FoodCartPostModel foodCartPostModel) async {
    emit(AddCartLoadingState(1));
    var uid = firebaseService.getUserUid() ?? '';
    foodCartPostModel.kullaniciAdi = uid;
    var result = await foodsRepo.addCart(foodCartPostModel);
    emit(AddCartLoadingState(0));
    return result;
  }

  Future<void> deleteFoodCart(List foodIdList) async {
    var uid = firebaseService.getUserUid() ?? '';
    for (var foodId in foodIdList) {
      await foodsRepo.deleteFoodCart(uid, int.parse(foodId));
    }

    getCart();
  }

  Future<FoodCartModel> getCart() async {
    emit(GetCartLoadingState(1));
    var uid = firebaseService.getUserUid() ?? '';
    foodCartModel = await foodsRepo.getCart(uid);
    totalCartPrice = 0;
    Map<String, dynamic> groupedFood = {};

    var cartList = foodCartModel.sepetYemekler ?? [];
    for (var item in cartList) {
      var foodName = item.yemekAdi ?? '';
      var foodPrice = int.parse(item.yemekFiyat ?? '0');
      var foodOrderCount = int.parse(item.yemekSiparisAdet ?? '0');
      var foodId = item.sepetYemekId ?? '';
      var foodImage = item.yemekResimAdi ?? '';

      var totalItemPrice = foodPrice * foodOrderCount;

      if (groupedFood.containsKey(foodName)) {
        groupedFood[foodName]['yemek_siparis_adet'] += foodOrderCount;
        groupedFood[foodName]['total_price'] += foodPrice * foodOrderCount;
        groupedFood[foodName]['sepet_yemek_id'].add(foodId);
        totalCartPrice += totalItemPrice;
      } else {
        groupedFood[foodName] = {
          'yemek_adi': foodName,
          'yemek_fiyat': foodPrice,
          'yemek_siparis_adet': foodOrderCount,
          'sepet_yemek_id': [foodId],
          'yemek_resim_adi': foodImage,
          'total_price': totalItemPrice,
        };
        totalCartPrice += totalItemPrice;
      }
    }

    groupedFoodList = groupedFood.values.toList();

    emit(GetCartLoadingState(0));
    return foodCartModel;
  }

  Future<void> addFavoriteFood(String foodID) async {
    await foodsRepo.addFavorite(foodID);
  }

  Future<void> removeFavoriteFood(String foodID) async {
    await foodsRepo.removeFavoriteFood(foodID);
  }

  Stream<List<String>> getFavoriteFoods() {
    return foodsRepo.getFavoriteFoods();
  }
}
