import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/data/response/status.dart';
import 'package:getx_tutorial/screens/meals/controllers/meal_controller.dart';

import '../../routes/route_constants.dart';
import '../cart/controller/cart_controller.dart';

class MealScreen extends StatelessWidget {
  MealScreen({super.key});

  final MealController mealController = Get.put(MealController());
  final CartController cartController = Get.put(CartController());
  final bool isAdded=false;
  @override
  Widget build(BuildContext context) {
    mealController.mealListApiCall(Get.arguments);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Meals", style: TextStyle(fontSize: 14)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Get.toNamed(cart),
              ),
              Obx(() => Positioned(
                top: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child:  Text(
                    cartController.products.length.toString(), // Replace this with your actual count
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
            ],
          )
        ],
      ),
      body: _mealView(context),
    );
  }

  Widget _mealView(context) {
    return Obx(() => switch (mealController.rxRequestStatus.value) {
          // TODO: Handle this case.
          Status.LOADING => const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            ),
          // TODO: Handle this case.
          Status.COMPLETED => ListView.builder(
              itemCount: mealController.mealList.value.meals?.length,
              itemBuilder: (BuildContext context, int index) {
                return _itemView(
                    context,
                    index,
                    Image.network(mealController
                        .mealList.value.meals![index].strMealThumb
                        .toString()),
                    mealController.mealList.value.meals?[index].strMeal ?? '',
                );
              }),
          // TODO: Handle this case.
          Status.ERROR => const Center(child: Text("No data found")),
        });
  }

  Widget _itemView(
      context, index, image, mealName) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: image,
        title: SizedBox(
            width: 80,
            child: Text(
              mealName ?? '',
              overflow: TextOverflow.clip,
              maxLines: 1,
              style:
                  const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800),
            )),
        subtitle: Obx(() => Visibility(
            visible:
                mealController.mealList.value.meals![index].isSelected.value,
            child: _counterView(index))),
        trailing: Obx(() => mealController.mealList.value.meals![index].isSelected.value
            ? InkWell(onTap:()=>mealController.toggleSelection(index,'remove'),child: const Icon(Icons.remove_shopping_cart, color: Colors.red))
            : InkWell(
          onTap: ()=>mealController.toggleSelection(index,'add'),
              child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.black12,
                      width: 2,
                    ),
                  ),
                  child: const Text("Add to cart")),
            )),
      ),
    );
  }

  Widget _counterView(index) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove, size: 16.0),
            onPressed: () => mealController.decreaseCount(index),
            color: Colors.black,
          ),
          Obx(() => Text(
                mealController.mealList.value.meals![index].itemCount.value
                    .toString(),
                style: const TextStyle(fontSize: 16, color: Colors.black),
              )),
          IconButton(
            icon: const Icon(Icons.add, size: 16.0),
            onPressed: () => mealController.increaseCount(index),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
