import '../product_model.dart';

class ProductRatingsRequestModel {
  ProductRatingsRequestModel({
    ProductSort? sort,
    int limit = 3,
    int page = 1,
    String status = 'active',
    required String productId,
  })  : _sortBy = SortType.getSortByValue(sort ?? ProductSort.newest),
        _sortOrder = SortType.getSortColumnValue(sort ?? ProductSort.newest),
        _limit = limit,
        _page = page,
        _productId = productId,
        _status = status;

  final String _sortBy;
  final String _sortOrder;
  final int _limit;
  final int _page;
  final String _productId;
  final String _status;

  Map<String, dynamic> toJson() => {
        'sort_column': _sortBy,
        'sort_order': _sortOrder,
        'limit': _limit,
        'page': _page,
        'product_id': _productId,
        'status': _status,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
