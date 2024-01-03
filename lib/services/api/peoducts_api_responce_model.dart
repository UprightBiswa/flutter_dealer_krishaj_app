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
  final String companyCode;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final String productImageUrl;

  ProductItem({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.companyCode,
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
      companyCode: json['company_code'] ?? '',
      userId: json['user_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      productImageUrl: json['product_image_url'] ?? '',
    );
  }
}

class ApiResponseModelProductDetails {
  final bool success;
  final String message;
  final ProductDetailsData? productDetails;

  ApiResponseModelProductDetails({
    required this.success,
    required this.message,
    this.productDetails,
  });

  factory ApiResponseModelProductDetails.fromJson(Map<String, dynamic> json) {
    return ApiResponseModelProductDetails(
      success: json['success'] ?? false,
      message: json['message'] is String ? json['message'] : '',
      productDetails: json['message'] != null
          ? ProductDetailsData.fromJson(json['message'])
          : null,
    );
  }
}

class ProductDetailsData {
  final int id;
  final String productName;
  final String productImage;
  final List<String> companyCodes; // Change the type to List<String>
  final String userId;
  final String createdAt;
  final String updatedAt;
  final String productImageUrl;

  ProductDetailsData({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.companyCodes,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.productImageUrl,
  });

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) {
    return ProductDetailsData(
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? '',
      productImage: json['product_image'] ?? '',
      companyCodes: List<String>.from(json['company_codes'] ?? []),
      userId: json['user_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      productImageUrl: json['product_image_url'] ?? '',
    );
  }
}
