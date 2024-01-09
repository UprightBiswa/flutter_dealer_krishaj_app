class EditUserInfoResponse {
  final bool success;
  final String message;

  EditUserInfoResponse({
    required this.success,
    required this.message,
  });

  factory EditUserInfoResponse.fromJson(Map<String, dynamic> json) {
    return EditUserInfoResponse(
      success: json['success'],
      message: json['message'],
    );
  }
}
