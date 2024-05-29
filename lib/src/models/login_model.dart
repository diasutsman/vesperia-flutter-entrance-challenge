class LoginModel {
  LoginModel({
    required this.token,
  });

  final String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
