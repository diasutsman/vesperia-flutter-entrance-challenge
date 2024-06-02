import 'dart:collection';

import '../product_model.dart';

class ProductDetailResponseModel {
  ProductDetailResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final ProductModel data;

  factory ProductDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponseModel(
        status: json['status'] ?? 0,
        message: json['message'] ?? 'success',
        data: ProductModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
