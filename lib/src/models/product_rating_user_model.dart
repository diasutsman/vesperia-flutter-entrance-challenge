class ProductRatingUserModel {
  ProductRatingUserModel({
    required this.id,
    required this.name,
    this.profilePicture,
  });

  final String id;
  final String name;
  final String? profilePicture;

  factory ProductRatingUserModel.fromJson(Map<String, dynamic> json) =>
      ProductRatingUserModel(
        id: json['id'],
        name: json['name'],
        profilePicture: json['profile_picture'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'profile_picture': profilePicture,
      };
}
