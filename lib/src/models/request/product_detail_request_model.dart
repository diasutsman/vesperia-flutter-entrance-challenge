import '../product_model.dart';

class ProductDetailRequestModel {
  ProductDetailRequestModel({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() => {
        'id': id,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
