class ApiResponseModel {
  final bool success;
  final String message;
  final int totalProducts;

  ApiResponseModel({
    required this.success,
    required this.message,
    required this.totalProducts,
  });
}
