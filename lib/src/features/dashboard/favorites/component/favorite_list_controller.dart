import 'package:entrance_test/src/features/dashboard/products/list/component/product_list_controller.dart';
import 'package:entrance_test/src/repositories/favorite_repository.dart';
import 'package:get/get.dart';
import 'package:entrance_test/src/models/product_model.dart';
import 'package:entrance_test/src/models/request/product_list_request_model.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';

class FavoriteListController extends GetxController {
  final FavoriteRepository _favoriteRepository;

  FavoriteListController({
    required FavoriteRepository favoriteRepository,
  }) : _favoriteRepository = favoriteRepository;

  final _products = Rx<List<ProductModel>>([]);

  List<ProductModel> get products => _products.value;

  final _isLoadingRetrieveProduct = false.obs;
  bool get isLoadingRetrieveProduct => _isLoadingRetrieveProduct.value;

  final _isLoadingRetrieveMoreProduct = false.obs;
  bool get isLoadingRetrieveMoreProduct => _isLoadingRetrieveMoreProduct.value;

  final _isLastPageProduct = false.obs;
  bool get isLastPageProduct => _isLastPageProduct.value;

  //The number of product retrieved each time a call is made to server
  final _limit = 10;

  //The number which shows how many product already loaded to the device,
  //thus giving the command to ignore the first x number of data when retrieving
  int _skip = 0;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  //first load or after refresh.
  void getProducts() async {
    print('getProducts in FavoriteListController');
    _isLoadingRetrieveProduct.value = true;
    _skip = 0;
    try {
      final productList =
          await _favoriteRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      _products.value = productList.data;
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error, st) {
      print(error);
      print(st);
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveProduct.value = false;
  }

  void getMoreProducts() async {
    print('favoriteList getMoreProducts');
    if (_isLastPageProduct.value || _isLoadingRetrieveMoreProduct.value) return;

    _isLoadingRetrieveMoreProduct.value = true;

    try {
      final productList =
          await _favoriteRepository.getProductList(ProductListRequestModel(
        limit: _limit,
        skip: _skip,
      ));
      _products.value = [..._products.value, ...productList.data];
      _isLastPageProduct.value = productList.data.length < _limit;
      _skip = products.length;
    } catch (error, st) {
      print(error);
      print(st);
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
    _isLoadingRetrieveMoreProduct.value = false;
  }

  void toProductDetail(ProductModel product) async {
    //TODO: finish this implementation by creating product detail page & calling it here
  }

  void setFavorite(ProductModel product) async {
    if (product.isFavorite = !product.isFavorite) {
      await _favoriteRepository.like(product);
    } else {
      await _favoriteRepository.dislike(product);
    }

    //* Only to reload favorite list, probably there are better ways to do this
    getProducts();
    Get.find<ProductListController>().getProducts();
  }
}
