import 'dart:collection';

import '../product_model.dart';

class ProductListResponseModel {
  ProductListResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final List<ProductModel> data;

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json,
          {HashSet<String>? liked}) =>
      ProductListResponseModel(
        status: json['status'],
        message: json['message'],
        data: List<ProductModel>.from(
                json['data'].map((x) => ProductModel.fromJson(x)))
            // .where((x) => liked?.contains(x.id) == true)
            .map((e) {
          e.isFavorite = liked?.contains(e.id) ?? false;
          return e;
        }).toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
