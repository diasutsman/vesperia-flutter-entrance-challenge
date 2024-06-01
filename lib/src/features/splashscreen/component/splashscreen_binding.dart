import 'package:dio/dio.dart';
import 'package:entrance_test/src/databases/favorite_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../repositories/user_repository.dart';
import 'splashscreen_controller.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteDatabase());

    Get.put(SplashscreenController(
      local: Get.find<GetStorage>(),
    ));
  }
}
