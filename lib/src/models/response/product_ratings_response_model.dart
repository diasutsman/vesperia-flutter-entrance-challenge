import 'package:entrance_test/src/models/product_rating_model.dart';

class ProductRatingsResponseModel {
  ProductRatingsResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final List<ProductRatingModel> data;

  factory ProductRatingsResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductRatingsResponseModel(
        status: json['status'] ?? 0,
        message: json['message'] ?? 'success',
        data: List<ProductRatingModel>.from(
          json['data'].map((x) => ProductRatingModel.fromJson(x)),
        ).toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
