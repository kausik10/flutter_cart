class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? productPrice;
  final int? productQuantity;
  final String? unitTag;
  final String? productImage;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.productQuantity,
    required this.unitTag,
    required this.productImage,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        initialPrice = res['initialPrice'],
        productPrice = res['productPrice'],
        productQuantity = res['productQuantity'],
        unitTag = res['unitTag'],
        productImage = res['productImage'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'unitTag': unitTag,
      'productImage': productImage,
    };
  }
}
