// In cart_screen.dart (continued)

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController()); // Get the CartController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Obx(() {
        final products = cartController.products;
        return products.isEmpty
            ? const Center(child: Text('Your cart is empty'))
            : ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.strMeal),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => (),
                  ),
                  Text("0"),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => (),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total : ${cartController.products.length}'),
            ElevatedButton(
              onPressed: () {
                // Handle checkout logic (optional)
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
