import 'package:entrance_test/src/models/request/update_user_request_model.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/date_util.dart';
import '../../../../../utils/networking_util.dart';
import '../../../../../widgets/snackbar_widget.dart';

class EditProfileController extends GetxController {
  final UserRepository _userRepository;

  EditProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final etFullName = TextEditingController();
  final etPhoneNumber = TextEditingController();
  final etEmail = TextEditingController();
  final etHeight = TextEditingController();
  final etWeight = TextEditingController();
  final etBirthDate = TextEditingController();

  final _countryCode = "".obs;

  String get countryCode => _countryCode.value;

  final _gender = ''.obs;

  String get gender => _gender.value;

  final _profilePictureUrlOrPath = ''.obs;

  String get profilePictureUrlOrPath => _profilePictureUrlOrPath.value;

  final _isLoadPictureFromPath = false.obs;

  bool get isLoadPictureFromPath => _isLoadPictureFromPath.value;

  final _isGenderFemale = false.obs;

  bool get isGenderFemale => _isGenderFemale.value;

  DateTime birthDate = DateTime.now();

  final _isUpdateProfileLoading = false.obs;
  bool get isUpdateProfileLoading => _isUpdateProfileLoading.value;

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return "Cannot be empty.";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Cannot be empty.";
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Invalid email.";
    }
    return null;
  }

  String? validateHeight(String? value) {
    if (value != null && value != '' && (int.tryParse(value) ?? -1) < 0) {
      return "cannot be negative.";
    }
    return null;
  }

  String? validateWeight(String? value) {
    if (value != null && value != '' && (int.tryParse(value) ?? -1) < 0) {
      return "Cannot be negative.";
    }
    return null;
  }

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
        etFullName.text = localUser.name;
        etPhoneNumber.text = localUser.phone;
        etEmail.text = localUser.email ?? '';
        etHeight.text = localUser.height?.toString() ?? '';
        etWeight.text = localUser.weight?.toString() ?? '';

        _countryCode.value = localUser.countryCode;

        _profilePictureUrlOrPath.value = localUser.profilePicture ?? '';
        _isLoadPictureFromPath.value = false;

        _gender.value = localUser.gender ?? '';
        if (gender.isNullOrEmpty || gender == 'laki_laki') {
          onChangeGender(false);
        } else {
          onChangeGender(true);
        }

        etBirthDate.text = '';
        if (localUser.dateOfBirth.isNullOrEmpty == false) {
          birthDate =
              DateUtil.getDateFromShortServerFormat(localUser.dateOfBirth!);
          etBirthDate.text = DateUtil.getBirthDate(birthDate);
        }
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error, stacktrace) {
      error.printError();
      print(stacktrace);
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  void changeImage() async {
    //TODO: Implement change profile image
  }

  void onChangeGender(bool isFemale) {
    if (isFemale) {
      _gender.value = 'perempuan';
    } else {
      _gender.value = 'laki_laki';
    }
    _isGenderFemale.value = isFemale;
  }

  void onChangeBirthDate(DateTime dateTime) {
    birthDate = dateTime;
    etBirthDate.text = DateUtil.getBirthDate(birthDate);
  }

  void saveData() async {
    try {
      if (formKey.currentState?.validate() == false) return;

      _isUpdateProfileLoading.value = true;
      await _userRepository.updateProfile(
        UpdateUserRequestModel(
          name: etFullName.text,
          email: etEmail.text,
          height: int.tryParse(etHeight.text),
          weight: int.tryParse(etWeight.text),
          dateOfBirth: DateUtil.getDateFromBirthDateFormat(etBirthDate.text),
          gender: _gender.value,
          profilePicture: profilePictureUrlOrPath,
        ),
      );
      SnackbarWidget.showSuccessSnackbar("Profile updated!");
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    } finally {
      _isUpdateProfileLoading.value = false;
    }
  }
}
