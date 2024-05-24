import 'package:get/get.dart';
import 'package:getx_tutorial/db/db_helper.dart';
import 'package:getx_tutorial/db/model/cart_model.dart';

class CartController extends GetxController {
  final _products = <CartItem>[].obs; // Observable list for products
  final addedProducts = <int>[].obs;
  final cartDatabase = DBHelper();

  @override
  void onInit() {
    super.onInit();
    _fetchProducts();
  }

  void _fetchProducts() async {
    final products = await cartDatabase.getCartItems();
    _products.value = products;
  }

  void addProduct(CartItem product,index) async {
    await cartDatabase.insertCartItem(product);
    addedProducts.add(product.id!);
    _fetchProducts();
  }

  // void updateProductQuantity(int id, int newQuantity) async {
  //   final product = _products.firstWhere((p) => p.id == id);
  //   product.copyWith(quantity: newQuantity);
  //   await cartDatabase.updateCartItemQuantity(id, newQuantity);
  //   _fetchProducts();
  // }



  void deleteProduct(int id) async {
    await cartDatabase.deleteCartItem(id);
    _fetchProducts();
  }

  // double getTotalPrice() {
  //   return _products.fold(0.0, (sum, product) => sum + product.price * product.quantity);
  // }

  List<CartItem> get products => _products;
}
