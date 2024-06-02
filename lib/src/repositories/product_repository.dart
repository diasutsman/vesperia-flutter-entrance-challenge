import 'package:dio/dio.dart';
import 'package:entrance_test/src/databases/favorite_database.dart';
import 'package:entrance_test/src/models/product_model.dart';
import 'package:entrance_test/src/models/request/product_detail_request_model.dart';
import 'package:entrance_test/src/models/request/product_ratings_request_model.dart';
import 'package:entrance_test/src/models/response/product_detail_response_model.dart';
import 'package:entrance_test/src/models/response/product_ratings_response_model.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/endpoint.dart';
import '../constants/local_data_key.dart';
import '../models/request/product_list_request_model.dart';
import '../models/response/product_list_response_model.dart';
import '../utils/networking_util.dart';

class ProductRepository {
  final Dio _client;
  final GetStorage _local;
  final FavoriteDatabase _favoriteDatabase;

  ProductRepository({
    required Dio client,
    required GetStorage local,
    required FavoriteDatabase favoriteDatabase,
  })  : _client = client,
        _local = local,
        _favoriteDatabase = favoriteDatabase;

  Future<ProductListResponseModel> getProductList(
      ProductListRequestModel request) async {
    try {
      String endpoint = Endpoint.getProductList;
      final responseJson = await _client.get(
        endpoint,
        data: request,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );

      final productListResponseModel =
          ProductListResponseModel.fromJson(responseJson.data);

      final likedIds = await _favoriteDatabase.getLikedProductIDsSet();

      for (final product in productListResponseModel.data) {
        if (likedIds.contains(product.id)) {
          product.isFavorite = true;
        }
      }

      return productListResponseModel;
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ProductDetailResponseModel> getProductDetail(
      ProductDetailRequestModel request) async {
    try {
      String endpoint = Endpoint.getProductList;
      final responseJson = await _client.get(
        '$endpoint/${request.id}',
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );

      final productDetailResponseModel =
          ProductDetailResponseModel.fromJson(responseJson.data);

      return productDetailResponseModel;
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ProductRatingsResponseModel> getProductRatings(
      ProductRatingsRequestModel request) async {
    try {
      String endpoint = Endpoint.getProductRating;
      final responseJson = await _client.get(
        endpoint,
        data: request,
        options: NetworkingUtil.setupNetworkOptions(
          'Bearer ${_local.read(LocalDataKey.token)}',
        ),
      );

      final productRatingsResponseModel =
          ProductRatingsResponseModel.fromJson(responseJson.data);

      return productRatingsResponseModel;
    } on DioError catch (_) {
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
