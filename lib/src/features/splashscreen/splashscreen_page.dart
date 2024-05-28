import 'package:entrance_test/src/features/login/component/login_controller.dart';
import 'package:entrance_test/src/features/splashscreen/component/splashscreen_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashscreenPage extends GetView<SplashscreenController> {
  const SplashscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Replace the below line with your actual app icon
              Image.asset('assets/icons/icon-app.png'),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Text(
              //     _version,
              //     style: const TextStyle(color: Colors.white, fontSize: 16),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
