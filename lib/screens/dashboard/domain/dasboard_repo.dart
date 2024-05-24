import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../AppUrl/app_url.dart';
import 'model/food_model.dart';

class DashboardRepo {

  Future fetchFoodData() async {
    Dio dio = Dio();
    try {
      // Make a GET request
      Response response =
      await dio.get('${Globals.baseUrl}/categories.php');
      if (kDebugMode) {
        debugPrint("BASE URL ====>${response.realUri}");
        debugPrint("RESPONSE ====>${response.data.toString()}");
      }

      return FoodModel.fromJson(response.data);
    } catch (e) {
      print('Error fetching data: $e');
      return e.toString();
    }
  }

}