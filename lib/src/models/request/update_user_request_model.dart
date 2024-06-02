class UpdateUserRequestModel {
  final String _name;
  final String _email;
  final String _gender;
  final DateTime _dateOfBirth;
  final int? _height;
  final int? _weight;
  final String profilePicture;
  UpdateUserRequestModel({
    required String name,
    required String email,
    required String gender,
    required DateTime dateOfBirth,
    required int? height,
    required int? weight,
    required this.profilePicture,
  })  : _name = name,
        _email = email,
        _gender = gender,
        _dateOfBirth = dateOfBirth,
        _height = height,
        _weight = weight;

  Map<String, dynamic> toJson() => {
        'name': _name,
        'email': _email,
        'gender': _gender,
        'date_of_birth': _dateOfBirth,
        'height': _height,
        'weight': _weight,
        'profile_picture': profilePicture,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
