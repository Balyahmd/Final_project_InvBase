// ignore_for_file: file_names

class RegisterRequestModel {
  String? username;
  String? password;

  RegisterRequestModel({
    this.username,
    this.password,
  });

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
