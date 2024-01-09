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
  final String materialNumber;
  final String materialType;
  final String materialGroup;
  final String baseUnitOfMeasure;
  final String grossWeight;
  final String netWeight;
  final String weightUnit;
  final String division;
  final String dateOfValidityStart;
  final String dateOfLastInspection;
  final String periodIndicatorOfShelfLifeExpirationDate;
  final String planningType;
  final String industrySectorOfMaterial;
  final String materialDescription;
  final String baseUnitMeasureOfDescription;
  final String additionalInfo;
  final String materialGroupDescription;
  final String materialGroup1;
  final String materialGroup2;
  final String materialGroup3;
  final String materialGroupDescription2;
  final String materialGroupDescription3;
  final String umrez;
  final String mseht;
  final String umren;
  final String createdAt;
  final String updatedAt;
  final String size;
  final String materialGroupDescriptionShort;
  final String productImageUrl;

  ProductItem({
    required this.id,
    required this.materialNumber,
    required this.materialType,
    required this.materialGroup,
    required this.baseUnitOfMeasure,
    required this.grossWeight,
    required this.netWeight,
    required this.weightUnit,
    required this.division,
    required this.dateOfValidityStart,
    required this.dateOfLastInspection,
    required this.periodIndicatorOfShelfLifeExpirationDate,
    required this.planningType,
    required this.industrySectorOfMaterial,
    required this.materialDescription,
    required this.baseUnitMeasureOfDescription,
    required this.additionalInfo,
    required this.materialGroupDescription,
    required this.materialGroup1,
    required this.materialGroup2,
    required this.materialGroup3,
    required this.materialGroupDescription2,
    required this.materialGroupDescription3,
    required this.umrez,
    required this.mseht,
    required this.umren,
    required this.createdAt,
    required this.updatedAt,
    required this.size,
    required this.materialGroupDescriptionShort,
    required this.productImageUrl,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] ?? 0,
      materialNumber: json['material_number'] ?? '',
      materialType: json['material_type'] ?? '',
      materialGroup: json['material_group'] ?? '',
      baseUnitOfMeasure: json['base_unit_of_measure'] ?? '',
      grossWeight: json['gross_weight'] ?? '',
      netWeight: json['net_weight'] ?? '',
      weightUnit: json['weight_unit'] ?? '',
      division: json['division'] ?? '',
      dateOfValidityStart: json['date_of_validity_start'] ?? '',
      dateOfLastInspection: json['date_of_last_inspection'] ?? '',
      periodIndicatorOfShelfLifeExpirationDate:
          json['period_indicator_of_shelf_life_expiration_date'] ?? '',
      planningType: json['planning_type'] ?? '',
      industrySectorOfMaterial: json['industry_sector_of_material'] ?? '',
      materialDescription: json['material_description'] ?? '',
      baseUnitMeasureOfDescription:
          json['base_unit_measure_of_description'] ?? '',
      additionalInfo: json['additional_info'] ?? '',
      materialGroupDescription: json['material_group_description'] ?? '',
      materialGroup1: json['material_group_1'] ?? '',
      materialGroup2: json['material_group_2'] ?? '',
      materialGroup3: json['material_group_3'] ?? '',
      materialGroupDescription2: json['material_group_description_2'] ?? '',
      materialGroupDescription3: json['material_group_description_3'] ?? '',
      umrez: json['umrez'] ?? '',
      mseht: json['mseht'] ?? '',
      umren: json['umren'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      size: json['size'] ?? '',
      materialGroupDescriptionShort:
          json['material_group_description_short'] ?? '',
      productImageUrl: json['product_image_url'] ?? '',
    );
  }
}


// class ProductItem {
//   final int id;
//   final String productName;
//   final String productImage;
//   final String companyCode;
//   final String userId;
//   final String createdAt;
//   final String updatedAt;
//   final String productImageUrl;

//   ProductItem({
//     required this.id,
//     required this.productName,
//     required this.productImage,
//     required this.companyCode,
//     required this.userId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.productImageUrl,
//   });

//   factory ProductItem.fromJson(Map<String, dynamic> json) {
//     return ProductItem(
//       id: json['id'] ?? 0,
//       productName: json['product_name'] ?? '',
//       productImage: json['product_image'] ?? '',
//       companyCode: json['company_code'] ?? '',
//       userId: json['user_id'] ?? '',
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       productImageUrl: json['product_image_url'] ?? '',
//     );
//   }
// }

//products details
// class ApiResponseModelProductDetails {
//   final bool success;
//   final String message;
//   final ProductDetailsData? productDetails;
//   final MaterialInfo? materialInfo;

//   ApiResponseModelProductDetails({
//     required this.success,
//     required this.message,
//     this.productDetails,
//     this.materialInfo,
//   });

//   factory ApiResponseModelProductDetails.fromJson(Map<String, dynamic> json) {
//     return ApiResponseModelProductDetails(
//       success: json['success'] ?? false,
//       message: json['message'] is String ? json['message'] : '',
//       productDetails: json['message'] != null
//           ? ProductDetailsData.fromJson(json['message'])
//           : null,
//       materialInfo: json['material_info'] != null
//           ? MaterialInfo.fromJson(json['material_info'])
//           : null,
//     );
//   }
// }

// class ProductDetailsData {
//   final int id;
//   final String productName;
//   final String productImage;
//   final List<String> companyCodes; // Change the type to List<String>
//   final String userId;
//   final String createdAt;
//   final String updatedAt;
//   final String productImageUrl;

//   ProductDetailsData({
//     required this.id,
//     required this.productName,
//     required this.productImage,
//     required this.companyCodes,
//     required this.userId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.productImageUrl,
//   });

//   factory ProductDetailsData.fromJson(Map<String, dynamic> json) {
//     return ProductDetailsData(
//       id: json['id'] ?? 0,
//       productName: json['product_name'] ?? '',
//       productImage: json['product_image'] ?? '',
//       companyCodes: List<String>.from(json['company_codes'] ?? []),
//       userId: json['user_id'] ?? '',
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       productImageUrl: json['product_image_url'] ?? '',
//     );
//   }
// }

// class MaterialInfo {
//   final int id;
//   final String materialNumber;
//   final String materialType;
//   final String materialGroup;
//   final String baseUnitOfMeasure;
//   final String grossWeight;
//   final String netWeight;
//   final String weightUnit;
//   final String division;
//   final String dateOfValidityStart;
//   final String dateOfLastInspection;
//   final String periodIndicatorOfShelfLifeExpirationDate;
//   final String planningType;
//   final String industrySectorOfMaterial;
//   final String materialDescription;
//   final String baseUnitMeasureOfDescription;
//   final String additionalInfo;
//   final String materialGroupDescription;
//   final String materialGroup1;
//   final String materialGroup2;
//   final String materialGroup3;
//   final String materialGroupDescription2;
//   final String materialGroupDescription3;
//   final String umrez;
//   final String mseht;
//   final String umren;
//   final String created_at;
//   final String updated_at;
//   final String size;
//   final String materialGroupDescriptionShort;
//   final int? price;

//   MaterialInfo({
//     required this.id,
//     required this.materialNumber,
//     required this.materialType,
//     required this.materialGroup,
//     required this.baseUnitOfMeasure,
//     required this.grossWeight,
//     required this.netWeight,
//     required this.weightUnit,
//     required this.division,
//     required this.dateOfValidityStart,
//     required this.dateOfLastInspection,
//     required this.periodIndicatorOfShelfLifeExpirationDate,
//     required this.planningType,
//     required this.industrySectorOfMaterial,
//     required this.materialDescription,
//     required this.baseUnitMeasureOfDescription,
//     required this.additionalInfo,
//     required this.materialGroupDescription,
//     required this.materialGroup1,
//     required this.materialGroup2,
//     required this.materialGroup3,
//     required this.materialGroupDescription2,
//     required this.materialGroupDescription3,
//     required this.umrez,
//     required this.mseht,
//     required this.umren,
//     required this.created_at,
//     required this.updated_at,
//     required this.size,
//     required this.materialGroupDescriptionShort,
//     required this.price,
//   });

//   factory MaterialInfo.fromJson(Map<String, dynamic> json) {
//     return MaterialInfo(
//       id: json['id'] ?? 0,
//       materialNumber: json['material_number'] ?? '',
//       materialType: json['material_type'] ?? '',
//       materialGroup: json['material_group'] ?? '',
//       baseUnitOfMeasure: json['base_unit_of_measure'] ?? '',
//       grossWeight: json['gross_weight'] ?? '',
//       netWeight: json['net_weight'] ?? '',
//       weightUnit: json['weight_unit'] ?? '',
//       division: json['division'] ?? '',
//       dateOfValidityStart: json['date_of_validity_start'] ?? '',
//       dateOfLastInspection: json['date_of_last_inspection'] ?? '',
//       periodIndicatorOfShelfLifeExpirationDate:
//           json['period_indicator_of_shelf_life_expiration_date'] ?? '',
//       planningType: json['planning_type'] ?? '',
//       industrySectorOfMaterial: json['industry_sector_of_material'] ?? '',
//       materialDescription: json['material_description'] ?? '',
//       baseUnitMeasureOfDescription:
//           json['base_unit_measure_of_description'] ?? '',
//       additionalInfo: json['additional_info'] ?? '',
//       materialGroupDescription: json['material_group_description'] ?? '',
//       materialGroup1: json['material_group_1'] ?? '',
//       materialGroup2: json['material_group_2'] ?? '',
//       materialGroup3: json['material_group_3'] ?? '',
//       materialGroupDescription2: json['material_group_description_2'] ?? '',
//       materialGroupDescription3: json['material_group_description_3'] ?? '',
//       umrez: json['umrez'] ?? '',
//       mseht: json['mseht'] ?? '',
//       umren: json['umren'] ?? '',
//       created_at: json['created_at'] ?? '',
//       updated_at: json['updated_at'] ?? '',
//       size: json['size'] ?? '',
//       materialGroupDescriptionShort:
//           json['material_group_description_short'] ?? '',
//       price: json['price'] as int?, // Use 'as int?' to accept null
//     );
//   }
// }
class ApiResponseModelProductDetails {
  final bool success;
  final ProductDetails? message;

  ApiResponseModelProductDetails({
    required this.success,
    required this.message,
  });

  factory ApiResponseModelProductDetails.fromJson(Map<String, dynamic> json) {
    return ApiResponseModelProductDetails(
      success: json['success'] ?? false,
      message: json['message'] != null ? ProductDetails.fromJson(json['message']) : null,
    );
  }
}

class ProductDetails {
  final int id;
  final String materialNumber;
  final String materialType;
  final String materialGroup;
  final String baseUnitOfMeasure;
  final String grossWeight;
  final String netWeight;
  final String weightUnit;
  final String division;
  final String dateOfValidityStart;
  final String dateOfLastInspection;
  final String periodIndicatorOfShelfLifeExpirationDate;
  final String planningType;
  final String industrySectorOfMaterial;
  final String materialDescription;
  final String baseUnitMeasureOfDescription;
  final String additionalInfo;
  final String materialGroupDescription;
  final String materialGroup1;
  final String materialGroup2;
  final String materialGroup3;
  final String materialGroupDescription2;
  final String materialGroupDescription3;
  final String umrez;
  final String mseht;
  final String umren;
  final String createdAt;
  final String updatedAt;
  final String size;
  final String materialGroupDescriptionShort;
  final String price;
  final String companyCodes;
  final String productImageUrl;

  ProductDetails({
    required this.id,
    required this.materialNumber,
    required this.materialType,
    required this.materialGroup,
    required this.baseUnitOfMeasure,
    required this.grossWeight,
    required this.netWeight,
    required this.weightUnit,
    required this.division,
    required this.dateOfValidityStart,
    required this.dateOfLastInspection,
    required this.periodIndicatorOfShelfLifeExpirationDate,
    required this.planningType,
    required this.industrySectorOfMaterial,
    required this.materialDescription,
    required this.baseUnitMeasureOfDescription,
    required this.additionalInfo,
    required this.materialGroupDescription,
    required this.materialGroup1,
    required this.materialGroup2,
    required this.materialGroup3,
    required this.materialGroupDescription2,
    required this.materialGroupDescription3,
    required this.umrez,
    required this.mseht,
    required this.umren,
    required this.createdAt,
    required this.updatedAt,
    required this.size,
    required this.materialGroupDescriptionShort,
    required this.price,
    required this.companyCodes,
    required this.productImageUrl,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] ?? 0,
      materialNumber: json['material_number'] ?? '',
      materialType: json['material_type'] ?? '',
      materialGroup: json['material_group'] ?? '',
      baseUnitOfMeasure: json['base_unit_of_measure'] ?? '',
      grossWeight: json['gross_weight'] ?? '',
      netWeight: json['net_weight'] ?? '',
      weightUnit: json['weight_unit'] ?? '',
      division: json['division'] ?? '',
      dateOfValidityStart: json['date_of_validity_start'] ?? '',
      dateOfLastInspection: json['date_of_last_inspection'] ?? '',
      periodIndicatorOfShelfLifeExpirationDate:
          json['period_indicator_of_shelf_life_expiration_date'] ?? '',
      planningType: json['planning_type'] ?? '',
      industrySectorOfMaterial: json['industry_sector_of_material'] ?? '',
      materialDescription: json['material_description'] ?? '',
      baseUnitMeasureOfDescription:
          json['base_unit_measure_of_description'] ?? '',
      additionalInfo: json['additional_info'] ?? '',
      materialGroupDescription: json['material_group_description'] ?? '',
      materialGroup1: json['material_group_1'] ?? '',
      materialGroup2: json['material_group_2'] ?? '',
      materialGroup3: json['material_group_3'] ?? '',
      materialGroupDescription2: json['material_group_description_2'] ?? '',
      materialGroupDescription3: json['material_group_description_3'] ?? '',
      umrez: json['umrez'] ?? '',
      mseht: json['mseht'] ?? '',
      umren: json['umren'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      size: json['size'] ?? '',
      materialGroupDescriptionShort:
          json['material_group_description_short'] ?? '',
      price: json['price'] ?? '',
      companyCodes: json['company_codes'] ?? '',
      productImageUrl: json['product_image_url'] ?? '',
    );
  }
}
