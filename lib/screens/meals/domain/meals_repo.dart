import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../AppUrl/app_url.dart';
import 'models/food_by_category_model.dart';

class MealsRepo {
  Future fetchFoodDataByCategory(categoryName) async {
    Dio dio = Dio();
    try {
      // Make a GET request
      Response response =
          await dio.get('${Globals.baseUrl}/filter.php?c=$categoryName');
      if (kDebugMode) {
        debugPrint("BASE URL ====>${response.realUri}");
        debugPrint("RESPONSE ====>${response.data.toString()}");
      }

      return FoodByCategoryModel.fromJson(response.data);
    } catch (e) {
      print('Error fetching data: $e');
      return e.toString();
    }
  }
}
