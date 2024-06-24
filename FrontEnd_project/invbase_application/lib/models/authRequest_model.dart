class AuthRequestModel {
  String? username;
  String? password;
  // String? image;

  AuthRequestModel({
    this.username,
    this.password,
  });

  AuthRequestModel.fromJson(Map<String, dynamic> json) {
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
