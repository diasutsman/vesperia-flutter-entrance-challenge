import 'package:cached_network_image/cached_network_image.dart';
import 'package:entrance_test/src/constants/icon.dart';
import 'package:entrance_test/src/features/boarding/component/boarding_controller.dart';
import 'package:entrance_test/src/features/login/component/login_controller.dart';
import 'package:entrance_test/src/features/splashscreen/component/splashscreen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BoardingPage extends GetView<BoardingController> {
  const BoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                ic_app_icon,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.currentIndex.value = index;
                },
                itemCount: controller.boardingData.length,
                itemBuilder: (context, index) {
                  final data = controller.boardingData[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title']!,
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              data['content']!,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF2E2E2E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.boardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.all(4.0),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: controller.currentIndex.value == index
                          ? Colors.blue
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => controller.currentIndex.value ==
                        controller.boardingData.length - 1
                    ? Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: controller.completeBoarding,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                backgroundColor: const Color(0xFF5D5FEF),
                              ),
                              child: const Text(
                                'Finish',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: controller.completeBoarding,
                              style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                              ),
                              child: const Text('Skip'),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                backgroundColor: const Color(0xFF5D5FEF),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
