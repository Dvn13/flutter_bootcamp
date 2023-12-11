import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/entity/foods_cart_post_model.dart';

class DetailFoodCubit extends Cubit<int> {
  DetailFoodCubit() : super(0);

  final FoodCartPostModel foodCartPostModel = FoodCartPostModel();

  void updateFoodCount(int change) {
    var count = state + change;
    if (count >= 0) {
      foodCartPostModel.yemekSiparisAdet = count;
      emit(count);
    }
  }

  void resetFoodCount() {
    emit(0); 
  }
}
