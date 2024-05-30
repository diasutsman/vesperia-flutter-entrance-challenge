import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashscreenController extends GetxController {
  final UserRepository _userRepository;

  SplashscreenController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
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

    try {
      //* Get user using current token
      await _userRepository.getUser();
      //* If no error occured then go to dashboard
      Get.offAllNamed(RouteName.dashboard);
    } catch (e) {
      //* Else, go to login
      Get.offAllNamed(RouteName.login);
    }
  }

  Future<String> loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return 'Ver: ${packageInfo.version}';
  }
}
