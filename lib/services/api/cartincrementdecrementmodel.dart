// cart_increment_decrement_model.dart

class CartIncrementDecrementModel {
  final bool success;
  final String message;
  

  CartIncrementDecrementModel({
    required this.success,
    required this.message,
    
  });

  factory CartIncrementDecrementModel.fromJson(Map<String, dynamic> json) {
    return CartIncrementDecrementModel(
     success: json['success'] ?? false, // Ensure it's a boolean
      message: json['message'],
    
     
    );
  }
}
