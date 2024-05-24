import 'package:get/get.dart';

class FoodByCategoryModel {
  List<Meals>? meals;

  FoodByCategoryModel({this.meals});

  FoodByCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;
   RxBool isSelected=false.obs;
   RxInt itemCount=0.obs;
  Meals({this.strMeal, this.strMealThumb, this.idMeal,required this.isSelected,required this.itemCount});

  Meals.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['strMeal'] = strMeal;
    data['strMealThumb'] = strMealThumb;
    data['idMeal'] = idMeal;
    return data;
  }
}
