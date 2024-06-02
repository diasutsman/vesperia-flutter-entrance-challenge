import 'package:dio/dio.dart';
import 'package:entrance_test/src/databases/favorite_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'boarding_controller.dart';

class BoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BoardingController(
      local: Get.find<GetStorage>(),
    ));
  }
}
