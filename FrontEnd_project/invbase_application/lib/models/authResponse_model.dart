class LoginResponseModel {
  String token;
  String username;
  String image;

  LoginResponseModel({
    required this.token,
    required this.username,
    required this.image,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'],
      username: json['username'],
      image: json['image'],
    );
  }
}
