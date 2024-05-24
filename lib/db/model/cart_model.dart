class CartItem {
  final int? id;
  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  CartItem({
    this.id,
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
      'idMeal': idMeal,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as int?,
      strMeal: map['strMeal'] as String,
      strMealThumb: map['strMealThumb'] as String,
      idMeal: map['idMeal'] as String,
    );
  }

  CartItem copyWith({
    int? id,
    String? strMeal,
    String? strMealThumb,
    String? idMeal,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      strMeal: strMeal ?? this.strMeal,
      strMealThumb: strMealThumb ?? this.strMealThumb,
      idMeal: idMeal ?? this.idMeal,
    );
  }
}