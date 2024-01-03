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
      productImage: json['product_image'],
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
    // Check if the message is "No data available"
    if (json['success'] == false && json['data'] == "No data available") {
      return ApiResponseModelCartItem(
        success: false,
        message: "No data available",
        totalProducts: 0,
        cartItems: [],
        totalPricesSum: "",
      );
    }

    List<dynamic> cartItemsJson = json['data'] ?? [];
    List<CartItem> cartItems = cartItemsJson
        .map((item) => CartItem.fromJson(Map<String, dynamic>.from(item)))
        .toList();

    return ApiResponseModelCartItem(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      totalProducts: json['total_products'] ?? 0,
      cartItems: cartItems,
      totalPricesSum:
          json['total_products_sum'] ?? '', // Adjust to total_products_sum
    );
  }
}

class RemoveCartItemResponse {
  final bool success;
  final String data;
  final int totalProducts;
  final String totalProductsSum; // Change type to String

  RemoveCartItemResponse({
    required this.success,
    required this.data,
    required this.totalProducts,
    required this.totalProductsSum,
  });

  factory RemoveCartItemResponse.fromJson(Map<String, dynamic> json) {
    return RemoveCartItemResponse(
      success: json['success'] ?? false,
      data: json['data'] ?? '',
      totalProducts: json['total_products'] ?? 0,
      totalProductsSum: json['total_products_sum']?.toString() ?? '0',
    );
  }
}


