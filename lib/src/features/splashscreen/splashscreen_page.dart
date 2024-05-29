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
            colors: [Color(0xFF37B133), Color(0xFF3337B1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset('assets/icons/icon-app.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder(
                    future: controller.loadVersion(),
                    builder: (context, snapshot) {
                      return Text(
                        textAlign: TextAlign.center,
                        snapshot.data ?? "loading...",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
