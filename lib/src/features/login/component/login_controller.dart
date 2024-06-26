import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _passwordVisible = false.obs;

  bool get passwordVisible => _passwordVisible.value;

  final _isLoadingLogin = false.obs;

  bool get isLoadingLogin => _isLoadingLogin.value;

  final _countryCode = '62'.obs;

  void setCountryCode(String countryCode) {
    _countryCode.value = countryCode.numericOnly();
  }

  void doLogin() async {
    try {
      _isLoadingLogin.value = true;
      if (formKey.currentState?.validate() == false) {
        return;
      }

      String phoneNumber = etPhone.text;
      String password = etPassword.text;

      await _userRepository.login(
        phoneNumber: phoneNumber,
        password: password,
        countryCode: _countryCode.value,
      );
      Get.offAllNamed(RouteName.dashboard);
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    } finally {
      _isLoadingLogin.value = false;
    }
  }

  void togglePasswordVisibility() {
    _passwordVisible.value = !passwordVisible;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.length < 8 || value.length > 16) {
      return "Phone number length must be within 8 to 16 characters";
    }

    if (!RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
      return "Phone number cannot have \"0\" as prefix";
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return "Password must be greater than or equal to 8 characters";
    }
    return null;
  }
}
