class VerifyOtpResponse {
  final bool success;
  final String message;
  final VerifyOtpData? data;

  VerifyOtpResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? VerifyOtpData.fromJson(json['data']) : null,
    );
  }
}

class VerifyOtpData {
  final int id;
  final String vendorCode;
  final String phoneNo;
  final String token;
  final String otp;
  final String createdAt;
  final String updatedAt;

  VerifyOtpData({
    required this.id,
    required this.vendorCode,
    required this.phoneNo,
    required this.token,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VerifyOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyOtpData(
      id: json['id'],
      vendorCode: json['vendor_code'],
      phoneNo: json['phone_no'],
      token: json['token'],
      otp: json['otp'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
