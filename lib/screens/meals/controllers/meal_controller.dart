import 'package:get/get.dart';
import 'package:getx_tutorial/db/model/cart_model.dart';
import 'package:getx_tutorial/screens/meals/domain/meals_repo.dart';
import 'package:getx_tutorial/screens/meals/domain/models/food_by_category_model.dart';

import '../../../data/response/status.dart';
import '../../../db/db_helper.dart';
import '../../cart/controller/cart_controller.dart';

class MealController extends GetxController {
  final _api = MealsRepo();
  final rxRequestStatus = Status.LOADING.obs;
  final mealList = FoodByCategoryModel().obs;
  RxString error = ''.obs;
  final CartController cartController = Get.put(CartController());

  int increaseCount(index) {
    final newQuantity = mealList.value.meals![index].itemCount.value++;
    //cartController.updateProductQuantity(int.parse(mealList.value.meals![index].idMeal.toString()), newQuantity);
    update();
    return newQuantity;
  }

  void decreaseCount(index) {
    mealList.value.meals![index].itemCount.value--;
    update();
  }

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setMealList(FoodByCategoryModel _value) => mealList.value = _value;

  void setError(String _value) => error.value = _value;

  void mealListApiCall(categoryName) {
    setRxRequestStatus(Status.LOADING);
    Future.delayed(const Duration(seconds: 2));
    _api.fetchFoodDataByCategory(categoryName).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setMealList(value);
    }).onError((error, stackTrace) {
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void toggleSelection(int index, type) {
    mealList.value.meals![index].isSelected.toggle();
    CartItem product = CartItem(
      strMeal: mealList.value.meals?[index].strMeal ?? '',
      strMealThumb: mealList.value.meals?[index].strMealThumb ?? '',
      idMeal: mealList.value.meals?[index].idMeal ?? '',
    );
    switch (type) {
      case 'add':
        cartController.addProduct(product, index);
      case 'remove':
        cartController.deleteProduct(
            int.parse(mealList.value.meals![index].idMeal.toString()));
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
