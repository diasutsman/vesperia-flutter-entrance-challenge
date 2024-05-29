import 'package:entrance_test/app/routes/route_name.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    navigateToLogin();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.onClose();
  }

  void navigateToLogin() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(RouteName.login);
      },
    );
  }

  Future<String> loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'Ver: ${packageInfo.version}';
  }
}
