import '../update_user_model.dart';

class UpdateUserResponseModel {
  UpdateUserResponseModel(
      {required this.status, required this.message, required this.data});

  final int status;
  final String message;
  final UpdateUserModel data;

  factory UpdateUserResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserResponseModel(
        status: json['status'],
        message: json['message'],
        data: UpdateUserModel.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
