import 'package:entrance_test/src/models/product_model.dart';
import 'package:entrance_test/src/models/product_rating_model.dart';
import 'package:entrance_test/src/models/request/product_detail_request_model.dart';
import 'package:entrance_test/src/models/request/product_ratings_request_model.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../app/routes/route_name.dart';
import '../../../../../widgets/snackbar_widget.dart';

class ProductDetailController extends GetxController {
  final ProductRepository _productRepository;

  ProductDetailController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  final _product = Rx<ProductModel?>(null);

  ProductModel? get product => _product.value;

  final _isProductDetailLoading = false.obs;
  bool get isProductDetailLoading => _isProductDetailLoading.value;

  final _productRatings = Rx<List<ProductRatingModel>>([]);

  List<ProductRatingModel> get productRatings => _productRatings.value;

  final _isProductRatingsLoading = false.obs;
  bool get isProductRatingsLoading => _isProductRatingsLoading.value;

  @override
  void onInit() {
    getDetail();
    getProductRatings();
    super.onInit();
  }

  void getDetail() async {
    try {
      _isProductDetailLoading.value = true;
      final id = Get.parameters['productId'].toString();
      final productDetailResponse = await _productRepository
          .getProductDetail(ProductDetailRequestModel(id: id));
      _product.value = productDetailResponse.data;
    } catch (error, st) {
      print(error);
      print(st);
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    } finally {
      _isProductDetailLoading.value = false;
    }
  }

  void getProductRatings() async {
    try {
      _isProductRatingsLoading.value = true;
      final id = Get.parameters['productId'].toString();
      final productDetailResponse = await _productRepository
          .getProductRatings(ProductRatingsRequestModel(productId: id));
      _productRatings.value = productDetailResponse.data;
    } catch (error, st) {
      print(error);
      print(st);
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    } finally {
      _isProductRatingsLoading.value = false;
    }
  }
}
