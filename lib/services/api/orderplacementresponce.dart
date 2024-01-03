class OrderPlacementResponse {
  final bool success;
  final String message;
  final String? orderId; // It can be null if success is false
  final int cartCount; // It can be null if success is false

  OrderPlacementResponse({
    required this.success,
    required this.message,
    this.orderId,
    required this.cartCount,
  });

  factory OrderPlacementResponse.fromJson(Map<String, dynamic> json) {
    return OrderPlacementResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      orderId: json['Order ID'],
      cartCount: json['Cartcount'] ?? 0,
    );
  }
}
