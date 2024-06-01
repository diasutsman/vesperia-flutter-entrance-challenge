import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get_storage/get_storage.dart';

class SplashscreenController extends GetxController {
  final GetStorage _local;
  SplashscreenController({
    required GetStorage local,
  }) : _local = local;
  @override
  void onInit() {
    super.onInit();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    navigateToNextPage();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.onClose();
  }

  void navigateToNextPage() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    //* if token exists then go to dashboard
    if (_local.hasData(LocalDataKey.token)) {
      Get.offAllNamed(RouteName.dashboard);
    } else {
      //* Else, go to login
      Get.offAllNamed(RouteName.login);
    }
  }

  Future<String> loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'Ver: ${packageInfo.version}';
  }
}
