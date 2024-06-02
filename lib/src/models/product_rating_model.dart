import 'package:entrance_test/src/models/product_rating_user_model.dart';

class ProductRatingModel {
  ProductRatingModel({
    required this.id,
    required this.createdAt,
    required this.review,
    required this.rating,
    required this.user,
  });

  final String id;
  final DateTime createdAt;
  final String review;

  final int rating;
  final ProductRatingUserModel user;

  factory ProductRatingModel.fromJson(Map<String, dynamic> json) =>
      ProductRatingModel(
        id: json['id'],
        createdAt: DateTime.parse(json['created_at']),
        review: json['review'],
        rating: json['rating'],
        user: ProductRatingUserModel.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt,
        'review': review,
        'rating': rating,
        'user': user,
      };
}

enum ProductSort {
  newest,
  priceAscending,
  priceDescending,
  nameAscending,
  nameDescending,
}

extension SortExtension on ProductSort {
  String get name {
    switch (this) {
      case ProductSort.newest:
        return 'Newest';
      case ProductSort.priceAscending:
        return 'Price: Low to High';
      case ProductSort.priceDescending:
        return 'Price: High to Low';
      case ProductSort.nameAscending:
        return 'Alphabet: A to Z';
      case ProductSort.nameDescending:
        return 'Alphabet: Z to A';
      default:
        return 'Newest';
    }
  }
}

class SortType {
  static String getSortByValue(ProductSort sort) {
    switch (sort) {
      case ProductSort.newest:
        return 'created_at';
      case ProductSort.nameAscending:
        return 'name';
      case ProductSort.nameDescending:
        return 'name';
      case ProductSort.priceAscending:
        return 'price';
      case ProductSort.priceDescending:
        return 'price';
      default:
        return 'id';
    }
  }

  static String getSortColumnValue(ProductSort sort) {
    switch (sort) {
      case ProductSort.newest:
        return 'desc';
      case ProductSort.nameAscending:
        return 'asc';
      case ProductSort.nameDescending:
        return 'desc';
      case ProductSort.priceAscending:
        return 'asc';
      case ProductSort.priceDescending:
        return 'desc';
      default:
        return 'asc';
    }
  }
}
