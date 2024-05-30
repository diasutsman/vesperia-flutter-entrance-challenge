import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../constants/color.dart';
import '../../constants/icon.dart';
import '../../widgets/button_icon.dart';
import 'component/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16,
              color: gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Hi, Welcome Back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sign in to your account.',
                    style: TextStyle(
                      fontSize: 16,
                      color: gray500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Phone Number',
                                  style: TextStyle(color: gray900),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: red500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        controller.setCountryCode(number.dialCode ?? '+62');
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        useBottomSheetSafeArea: true,
                      ),
                      validator: controller.validatePhoneNumber,
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: PhoneNumber(isoCode: 'ID'),
                      textFieldController: controller.etPhone,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: const OutlineInputBorder(),
                      spaceBetweenSelectorAndTextField: 4,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Password',
                                  style: TextStyle(color: gray900),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: red500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray900),
                        obscureText: !controller.passwordVisible,
                        cursorColor: primary,
                        validator: controller.validatePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: controller.togglePasswordVisibility,
                            icon: Icon(
                              controller.passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            right: -14,
                            top: 20,
                            bottom: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                const BorderSide(color: gray200, width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide:
                                const BorderSide(color: gray200, width: 1.5),
                          ),
                          fillColor: white,
                          filled: true,
                          hintText: 'Password',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: ImageIcon(
                              AssetImage(ic_password),
                            ), // icon is 48px widget.
                          ),
                        ),
                        controller: controller.etPassword,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                loginButton(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => SizedBox(
        height: 52,
        width: double.infinity,
        child: Obx(
          () => ButtonIcon(
            buttonColor: primary,
            textColor: white,
            textLabel: "Sign In",
            isLoading: controller.isLoadingLogin,
            onClick: () {
              controller.doLogin();
            },
          ),
        ),
      );
}
