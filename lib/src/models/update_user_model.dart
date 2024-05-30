class UpdateUserModel {
  UpdateUserModel({
    required this.name,
    this.email,
    required this.phone,
    this.profilePicture,
    this.dateOfBirth,
    this.gender,
    this.profilePictureUrl,
  });

  final String name;
  final String phone;
  final String? profilePicture;
  final String? email;
  final String? gender;
  final String? dateOfBirth;
  final String? profilePictureUrl;

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
        name: json['name'],
        phone: json['phone_number'],
        profilePicture: json['profile_picture'],
        email: json['email'],
        gender: json['gender'],
        dateOfBirth: json['date_of_birth'],
        profilePictureUrl: json['profile_picture_url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone_number': phone,
        'profile_picture': profilePicture,
        'email': email,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'profile_picture_url': profilePictureUrl,
      };
}
