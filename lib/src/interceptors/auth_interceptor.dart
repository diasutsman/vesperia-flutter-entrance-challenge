import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:get/get.dart'
    hide Response; //* Hide Response class from get.dart
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:get_storage/get_storage.dart';

class AuthInterceptor extends Interceptor {
  final GetStorage storage;

  AuthInterceptor({required this.storage});

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {

  // }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // Proceed with the response if the status code is not 401
    if (err.response?.statusCode != 401) {
      super.onError(err, handler);
      return;
    }
    
    // Handle 401 Unauthorized response
    _handleUnauthorizedResponse();
  }

  void _handleUnauthorizedResponse() {
    // Delete user credentials
    storage.remove(LocalDataKey.token);
    // Navigate to login page
    Get.offAllNamed(RouteName.login);
  }
}
