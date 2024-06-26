import 'dart:collection';

import '../product_model.dart';

class ProductListResponseModel {
  ProductListResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final List<ProductModel> data;

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductListResponseModel(
        status: json['status'] ?? 0,
        message: json['message'] ?? 'success',
        data: List<ProductModel>.from(
          json['data'].map((x) => ProductModel.fromJson(x)),
        ).toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
