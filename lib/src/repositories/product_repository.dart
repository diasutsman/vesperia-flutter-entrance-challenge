import 'package:dio/dio.dart';
import 'package:entrance_test/src/databases/favorite_database.dart';
import 'package:entrance_test/src/models/product_model.dart';
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
      final liked = await _favoriteDatabase.getLikedProductIds();

      return ProductListResponseModel.fromJson(responseJson.data, liked: liked);
    } on DioError catch (_) {
      rethrow;
    }
  }

  like(ProductModel product) {
    _favoriteDatabase.like(product);
  }

  dislike(ProductModel product) {
    _favoriteDatabase.dislike(product);
  }
}
