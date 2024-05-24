import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/screens/dashboard/domain/dasboard_repo.dart';
import 'package:getx_tutorial/screens/dashboard/domain/model/food_model.dart';

import '../../../data/response/status.dart';

class DashboardController extends GetxController {
  final _api = DashboardRepo();
  final rxRequestStatus = Status.LOADING.obs;
  final mealCategoryList = FoodModel().obs;
  RxString error = ''.obs;
  RxList category = [].obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setMealCategories(FoodModel _value) => mealCategoryList.value = _value;

  void mealCategoryListApiCall() async {
    await _api.fetchFoodData().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setMealCategories(value);
    }).onError((error, stackTrace) {
      setRxRequestStatus(Status.ERROR);
      Get.snackbar("Error occurred", error.toString(),
          backgroundColor: Colors.amberAccent,
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  @override
  void onInit() {
    super.onInit();
    mealCategoryListApiCall();
  }

  @override
  void onReady() {

    super.onReady();
  }

  void filterSearch(String searchValue) {
    print("this block is called for search");
    List<Categories> results = [];
    if (searchValue.isEmpty) {
      results = mealCategoryList.value.categories ?? [];
      print(" empty is called for search!! ${results.length}");
    } else {
      results = mealCategoryList.value.categories!
          .where((item) => item.strCategory
              .toString()
              .toLowerCase()
              .trim()
              .contains(searchValue.toLowerCase().trim()))
          .toList();
      print("not empty is called for search!! ${results.length}");
    }
    mealCategoryList.value.categories = results;
  }
}
