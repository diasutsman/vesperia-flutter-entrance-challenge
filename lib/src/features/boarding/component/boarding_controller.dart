import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:get_storage/get_storage.dart';

class BoardingController extends GetxController {
  final GetStorage _local;
  BoardingController({
    required GetStorage local,
  }) : _local = local;
  var currentIndex = 0.obs;
  final PageController pageController = PageController();

  List<Map<String, String>> boardingData = [
    {
      'title': 'Welcome to Our App',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'title': 'Title 1',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    },
    {
      'title': 'Title 2',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    }
  ];

  Future<void> completeBoarding() async {
    _local.write(LocalDataKey.boarded, true);
    Get.offNamed(RouteName.login);
  }
}
