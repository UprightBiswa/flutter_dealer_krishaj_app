class UserInfoResponse {
  bool success;
  dynamic message; // Use dynamic type to handle both string and UserInfoMessage

  UserInfoResponse({
    required this.success,
    required this.message,
  });

 factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      success: json['success'],
      message: json['message'] != null
          ? UserInfoMessage.fromJson(json['message'] as Map<String, dynamic>)
          : null,
    );
  }
}


class UserInfoMessage {
  int id;
  String customerNumber;
  String customerName;
  String mobileNumber;
  String panNumber;
  String smtpAddress;
  String customerTaxNumber;
  String regionCode;
  String regionDescription;
  String customerCreditLimit;
  String customerAvailableCredit;
  String? dateOfBirth; // Nullable date fields
  String? anniversaryDate; // Nullable date fields
  String? itrSubmit;
  String? geotag;
  String? email;
  String? alternativeMobileNo;
  String? itrImage; // Nullable field for itr_image
  String? itrNumber; // Nullable field for itr_number
  String createdAt;
  String updatedAt;

  UserInfoMessage({
    required this.id,
    required this.customerNumber,
    required this.customerName,
    required this.mobileNumber,
    required this.panNumber,
    required this.smtpAddress,
    required this.customerTaxNumber,
    required this.regionCode,
    required this.regionDescription,
    required this.customerCreditLimit,
    required this.customerAvailableCredit,
    required this.dateOfBirth,
    required this.anniversaryDate,
    required this.itrSubmit,
    required this.geotag,
    required this.email,
    required this.alternativeMobileNo,
    required this.itrImage,
    required this.itrNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserInfoMessage.fromJson(Map<String, dynamic> json) {
    return UserInfoMessage(
      id: json['id'] ?? 0,
      customerNumber: json['customer_number'] ?? '',
      customerName: json['customer_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      panNumber: json['pan_number'] ?? '',
      smtpAddress: json['smtp_address'] ?? '',
      customerTaxNumber: json['customer_tax_number'] ?? '',
      regionCode: json['region_code'] ?? '',
      regionDescription: json['region_description'] ?? '',
      customerCreditLimit: (json['customer_credit_limit'] as String?)?.trim() ?? '',
      customerAvailableCredit: (json['customer_available_credit'] as String?)?.trim() ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      anniversaryDate: json['anniversary_date'] ?? '',
      itrSubmit: json['itr_submit'] ?? '',
      geotag: json['geotag'] ?? '',
      email: json['email'] ?? '',
      alternativeMobileNo: json['alternative_mobile_no'] ?? '',
      itrImage: json['itr_image'] ?? '',
      itrNumber: json['itr_number']  ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
