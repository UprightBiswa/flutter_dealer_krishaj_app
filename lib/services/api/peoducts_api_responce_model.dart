class ApiResponseModelProducts {
  final bool success;
  final dynamic message; // Change the type to dynamic
  final List<ProductItem> products;

  ApiResponseModelProducts({
    required this.success,
    required this.message,
    required this.products,
  });

  factory ApiResponseModelProducts.fromJson(Map<String, dynamic> json) {
    dynamic message = json['message'];
    List<ProductItem> products = [];

    if (message is List) {
      // If 'message' is a list, parse it as a list of products
      products = message
          .map((item) => ProductItem.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

    return ApiResponseModelProducts(
      success: json['success'] ?? false,
      message: message ?? '',
      products: products,
    );
  }
}

class ProductItem {
  final int id;
  final String productName;
  final String productImage;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final String productImageUrl;

  ProductItem({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.productImageUrl,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? '',
      productImage: json['product_image'] ?? '',
      userId: json['user_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      productImageUrl: json['product_image_url'] ?? '',
    );
  }
}
