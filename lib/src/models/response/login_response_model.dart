import '../login_model.dart';

class LoginResponseModel {
  LoginResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final LoginModel data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json['status'],
        message: json['message'],
        data: LoginModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
