class CartItem {
  final int id;
  final String productId;
  final String quantity;
  final String price;
  final String totalPrice;
  final String userId;
  final String token;
  final String status;
  final String company;
  final String createdAt;
  final String updatedAt;
  final String? productImage;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.userId,
    required this.token,
    required this.status,
    required this.company,
    required this.createdAt,
    required this.updatedAt,
     this.productImage,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? '',
      quantity: json['quantity'] ?? '',
      price: json['price'] ?? '',
      totalPrice: json['total_price'] ?? '',
      userId: json['user_id'] ?? '',
      token: json['token'] ?? '',
      status: json['status'] ?? '',
      company: json['company'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      productImage: json['product_image'] ,
    );
  }
}


class ApiResponseModelCartItem {
  final bool success;
  final String message;
  final int totalProducts;
  final List<CartItem> cartItems;
  final String totalPricesSum;

  ApiResponseModelCartItem({
    required this.success,
    required this.message,
    required this.totalProducts,
    required this.cartItems,
    required this.totalPricesSum,
  });

  factory ApiResponseModelCartItem.fromJson(Map<String, dynamic> json) {
    List<dynamic> cartItemsJson = json['data'] ?? [];
    List<CartItem> cartItems = cartItemsJson
        .map((item) => CartItem.fromJson(Map<String, dynamic>.from(item)))
        .toList();

   return ApiResponseModelCartItem(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      totalProducts: json['total_products'] ?? 0,
      cartItems: cartItems,
      totalPricesSum: json['total_products_sum'] ?? '', // Adjust to total_products_sum
    );
  }
}