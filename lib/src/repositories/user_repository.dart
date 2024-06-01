import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/databases/favorite_database.dart';
import 'package:entrance_test/src/models/request/update_user_request_model.dart';
import 'package:entrance_test/src/models/response/login_response_model.dart';
import 'package:entrance_test/src/models/response/logout_response_model.dart';
import 'package:entrance_test/src/models/response/update_user_response_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;
  final FavoriteDatabase _favoriteDatabase;

  UserRepository({
    required Dio client,
    required GetStorage local,
    required FavoriteDatabase favoriteDatabase,
  })  : _client = client,
        _local = local,
        _favoriteDatabase = favoriteDatabase;

  Future<LoginResponseModel> login({
    required String phoneNumber,
    required String password,
    String countryCode = '62',
  }) async {
    //Artificial delay to simulate logging in process
    // await Future.delayed(const Duration(seconds: 2));
    //Placeholder token. DO NOT call real logout API using this token
    // _local.write(
    //     LocalDataKey.token, "621|DBiUBMfsEtX01tbdu4duNRCNMTt7PV5blr6zxTvq");

    try {
      final responseJson = await _client.post(
        Endpoint.signIn,
        data: {
          "phone_number": phoneNumber,
          "password": password,
          "country_code": countryCode
        },
      );
      final model = LoginResponseModel.fromJson(responseJson.data);
      _local.write(
        LocalDataKey.token,
        model.data.token,
      );
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<LogoutResponseModel> logout() async {
    //Artificial delay to simulate logging out process
    // await Future.delayed(const Duration(seconds: 2));
    // await _local.remove(LocalDataKey.token);

    try {
      final responseJson = await _client.post(
        Endpoint.signOut,
        options: NetworkingUtil.setupNetworkOptions(
          'Bearer ${_local.read(LocalDataKey.token)}',
        ),
      );
      final model = LogoutResponseModel.fromJson(responseJson.data);
      _local.remove(
        LocalDataKey.token,
      );
      _favoriteDatabase.clear();
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<UserResponseModel> getUser() async {
    try {
      final responseJson = await _client.get(
        Endpoint.getUser,
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final model = UserResponseModel.fromJson(responseJson.data);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<UpdateUserResponseModel> updateProfile(
    UpdateUserRequestModel request,
  ) async {
    try {
      String endpoint = Endpoint.updateProfile;
      final responseJson = await _client.post(
        endpoint,
        data: FormData.fromMap({
          ...request.toJson(),
          '_method': 'PUT',
          'profile_picture': null,
        }),
        options: NetworkingUtil.setupNetworkOptions(
            'Bearer ${_local.read(LocalDataKey.token)}'),
      );
      return UpdateUserResponseModel.fromJson(responseJson.data);
    } on DioException catch (_) {
      rethrow;
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      await _local.write(
          LocalDataKey.token, '619|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');

      getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);
    } on DioException catch (_) {
      rethrow;
    }
  }
}
