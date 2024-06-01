import 'package:dio/dio.dart';
import 'package:entrance_test/src/databases/favorite_database.dart';
import 'package:entrance_test/src/features/dashboard/component/dashboard_controller.dart';
import 'package:entrance_test/src/features/dashboard/favorites/component/favorite_list_controller.dart';
import 'package:entrance_test/src/features/dashboard/products/list/component/product_list_controller.dart';
import 'package:entrance_test/src/repositories/favorite_repository.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../profile/component/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(FavoriteDatabase());

    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
      favoriteDatabase: Get.find<FavoriteDatabase>(),
    ));

    Get.put(ProductRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
      favoriteDatabase: Get.find<FavoriteDatabase>(),
    ));

    Get.put(FavoriteRepository(
      favoriteDatabase: Get.find<FavoriteDatabase>(),
    ));

    Get.put(
      DashboardController(),
    );

    Get.put(ProfileController(
      userRepository: Get.find<UserRepository>(),
    ));

    Get.put(FavoriteListController(
      favoriteRepository: Get.find<FavoriteRepository>(),
    ));

    Get.put(ProductListController(
      productRepository: Get.find<ProductRepository>(),
    ));
  }
}
