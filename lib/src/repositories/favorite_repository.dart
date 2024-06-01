import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:entrance_test/src/databases/favorite_database.dart';
import 'package:entrance_test/src/models/product_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/endpoint.dart';
import '../constants/local_data_key.dart';
import '../models/request/product_list_request_model.dart';
import '../models/response/product_list_response_model.dart';
import '../utils/networking_util.dart';

class FavoriteRepository {
  final FavoriteDatabase _favoriteDatabase;

  FavoriteRepository({
    required FavoriteDatabase favoriteDatabase,
  }) : _favoriteDatabase = favoriteDatabase;

  Future<ProductListResponseModel> getProductList(
      ProductListRequestModel request) async {
    try {
      final products = await _favoriteDatabase.getLikedProducts(request);

      final productListResponseModel = ProductListResponseModel.fromJson({
        'data': products.map((e) => e.toJson()).toList(),
      });

      for (final product in productListResponseModel.data) {
        product.isFavorite = true;
      }

      return productListResponseModel;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> like(ProductModel product) {
    return _favoriteDatabase.like(product);
  }

  Future<void> dislike(ProductModel product) {
    return _favoriteDatabase.dislike(product);
  }
}
