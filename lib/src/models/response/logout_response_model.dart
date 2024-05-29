import '../logout_model.dart';

class LogoutResponseModel {
  LogoutResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final LogoutModel data;

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) =>
      LogoutResponseModel(
        status: json['status'],
        message: json['message'],
        data: LogoutModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
