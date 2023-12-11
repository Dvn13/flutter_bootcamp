import 'package:food_app/data/entity/foods_cart_model.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';
import 'package:food_app/data/entity/foods_model.dart';
import 'package:food_app/data/entity/result_model.dart';
import 'package:food_app/data/services/firebase_service.dart';
import 'package:food_app/data/services/http_service.dart';
import 'package:food_app/data/services/path.dart';

class FoodsDaoRepository {
  HttpManager httpManager = HttpManager();
  FirebaseService firebaseService = FirebaseService();

  Future<List<Yemekler>> getFoods() async {
    List<Yemekler> foods = [];
    final result = (await httpManager.get(NetworkRoute.getFoods));

    var response = FoodsModel.fromJson(result);
    response.success == 1 ? foods = response.yemekler ?? [] : [];
    return foods;
  }

  Future<ResultModel> addCart(FoodCartPostModel foodCartPostModel) async {
    final result = (await httpManager.addCart(
        path: NetworkRoute.addCart, foodCartPostModel: foodCartPostModel));

    var response = result;

    return response;
  }

  Future<FoodCartModel> getCart(String kullaniciAdi) async {
    final result = (await httpManager.getCart(
        path: NetworkRoute.getCart, kullaniciAdi: kullaniciAdi));

    var response = result;

    return response;
  }

  Future<ResultModel> deleteFoodCart(
      String kullaniciAdi, int sepetYemekId) async {
    final result = (await httpManager.deleteFoodCart(
        path: NetworkRoute.deleteFoodCart,
        kullaniciAdi: kullaniciAdi,
        sepetYemekId: sepetYemekId));

    var response = result;

    return response;
  }

  List<Yemekler> search(List<Yemekler> list, String searchText) {
    var foodsList = list;

    foodsList = foodsList.where((yemek) {
      return yemek.yemekAdi!.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return foodsList;
  }

  Future<void> addFavorite(String foodID) async {
    await firebaseService.addFavoriteFood(foodID);
  }

  Future<void> removeFavoriteFood(String foodID) async {
    await firebaseService.removeFavoriteFood(foodID);
  }

 Stream<List<String>> getFavoriteFoods() {
    return firebaseService.getFavoriteFoods();
  }
}
