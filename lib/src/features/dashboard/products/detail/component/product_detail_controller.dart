import 'package:entrance_test/src/models/product_model.dart';
import 'package:entrance_test/src/models/product_rating_model.dart';
import 'package:entrance_test/src/models/request/product_detail_request_model.dart';
import 'package:entrance_test/src/models/request/product_ratings_request_model.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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

  final PagingController<int, ProductRatingModel>
      productRatingsPagingController = PagingController(
    firstPageKey: 1,
  );

  final DraggableScrollableController productRatingSheetController =
      DraggableScrollableController();

  static const _pageSize = 10;

  void snapToBothEndsProductSheet() {
    double toPosition = 0;
    productRatingSheetController.animateTo(
      toPosition,
      duration: Durations.medium4,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _fetchProductRatingPage(int pageKey) async {
    try {
      final id = Get.parameters['productId'].toString();
      final productDetailResponse = await _productRepository.getProductRatings(
        ProductRatingsRequestModel(
          productId: id,
          limit: _pageSize,
          page: pageKey,
        ),
      );
      final newItems = productDetailResponse.data;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        productRatingsPagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        productRatingsPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      productRatingsPagingController.error = error;
    }
  }

  @override
  void onInit() {
    getDetail();
    getProductRatings();
    productRatingsPagingController.addPageRequestListener((pageKey) {
      _fetchProductRatingPage(pageKey);
    });
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
      final productDetailResponse = await _productRepository.getProductRatings(
        ProductRatingsRequestModel(
          productId: id,
        ),
      );
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
