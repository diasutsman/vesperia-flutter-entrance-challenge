import 'package:dio/dio.dart';
import 'package:entrance_test/src/databases/favorite_database.dart';
import 'package:entrance_test/src/features/dashboard/component/dashboard_controller.dart';
import 'package:entrance_test/src/features/dashboard/favorites/component/favorite_list_controller.dart';
import 'package:entrance_test/src/features/dashboard/products/detail/component/product_detail_controller.dart';
import 'package:entrance_test/src/features/dashboard/products/list/component/product_list_controller.dart';
import 'package:entrance_test/src/repositories/favorite_repository.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(FavoriteDatabase());
    Get.put(ProductRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
      favoriteDatabase: Get.find<FavoriteDatabase>(),
    ));
    Get.put(ProductDetailController(
      productRepository: Get.find<ProductRepository>(),
    ));
  }
}
