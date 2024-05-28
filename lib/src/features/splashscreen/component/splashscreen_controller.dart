import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // navigateToLogin();
  }

  void navigateToLogin() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(RouteName.login);
      },
    );
  }
}
