import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/foods_model.dart';
import 'package:food_app/data/repo/foods_dao_repository.dart';
import 'package:food_app/ui/cubit/food_crud_cubit.dart';

class HomeCubit extends Cubit<List<Yemekler>> {
  HomeCubit() : super(<Yemekler>[]);
  var foodsRepo = FoodsDaoRepository();
  var favoriteFood = FoodCrudCubit();
  List<Yemekler> foodsList = [];
  List<Yemekler> searchfoodsList = [];
  

  Future<void> getFoods() async {
    var foods = await foodsRepo.getFoods();
    foodsList = foods;

  
    emit(foodsList);
  }

  Future<void> search(String searchText) async {
    var foods = foodsRepo.search(foodsList, searchText);
    if (searchText.isNotEmpty) {
      searchfoodsList = foods;
    } else {
      searchfoodsList = foodsList;
    }
    emit(searchfoodsList);
  }
}
