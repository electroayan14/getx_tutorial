import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'model/cart_model.dart';

class DBHelper {
  static const String dbName = 'cart.db';
  static const String cartTableName = 'cartItems';

   Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    return await openDatabase(
      path.join(databasePath, dbName),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $cartTableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            strMeal TEXT NOT NULL,
            strMealThumb TEXT NOT NULL,
            idMeal TEXT NOT NULL
          )
        ''');
      },
      version: 1,
    );
  }

   Future<int> insertCartItem(CartItem cartItem) async {
    final db = await getDatabase();
    return await db.insert(
      cartTableName,
      cartItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

   Future<List<CartItem>> getCartItems() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(cartTableName);
    return List.generate(maps.length, (i) => CartItem.fromMap(maps[i]));
  }


  // New function to update quantity
  Future<void> updateCartItemQuantity(int id, int newQuantity) async {
    final db = await getDatabase();
    await db.rawUpdate(
      '''
      UPDATE $cartTableName
      SET quantity = ?
      WHERE idMeal = ?
      ''',
      [newQuantity, id],
    );
  }

   Future<void> deleteCartItem(int id) async {
    final db = await getDatabase();
    await db.delete(
      cartTableName,
      where: 'idMeal = ?',
      whereArgs: [id],
    );
  }

   Future<void> deleteAllCartItems() async {
    final db = await getDatabase();
    await db.delete(cartTableName);
  }
}
