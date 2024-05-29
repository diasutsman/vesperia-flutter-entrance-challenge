import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  final _isLogoutLoading = false.obs;

  bool get isLogoutLoading => _isLogoutLoading.value;

  ProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty
            ? "+${localUser.countryCode}${localUser.phone}"
            : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  void onDownloadFileClick() async {
    final dio = Dio();
    const url = 'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf';

    // Request storage permissions
    if (await _requestPermissions()) {
      try {
        final directory = await getDownloadsDirectory();
        if (directory == null) {
          SnackbarWidget.showFailedSnackbar(
              'Unable to get downloads directory');
          return;
        }

        final filePath = '${directory.path}/flutter_tutorial.pdf';
        final response = await dio.download(url, filePath);

        if (response.statusCode == 200) {
          SnackbarWidget.showSuccessSnackbar('Download completed: $filePath');
        } else {
          SnackbarWidget.showFailedSnackbar('Download failed');
        }
      } catch (error) {
        SnackbarWidget.showFailedSnackbar('Error: ${error.toString()}');
      }
    } else {
      SnackbarWidget.showFailedSnackbar('Permission denied');
    }
  }

  Future<bool> _requestPermissions() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();
    }
    return null;
  }

  onOpenWebPageClick() {}

  void doLogout() async {
    _isLogoutLoading.value = true;
    await _userRepository.logout();
    Get.offAllNamed(RouteName.login);
    _isLogoutLoading.value = false;
  }
}
