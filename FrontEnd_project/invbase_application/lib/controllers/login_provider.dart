import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invbase_application/models/loginRequest_model.dart';

class LoginProvider extends ChangeNotifier {
  var formKeyLogin = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var loginState = StateLogin.initial;
  var username = '';
  var messageError = '';
  bool obscurePassword = true;
  late String token;
  final Dio _dio = Dio();

  Future<String?> processLogin(BuildContext context) async {
    if (formKeyLogin.currentState!.validate()) {
      try {
        LoginRequestModel requestModel = LoginRequestModel(
          username: usernameController.text,
          password: passwordController.text,
        );

        final response = await _dio.post(
          'http://192.168.1.7:3000/auth/login',
          data: requestModel.toJson(),
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        if (response.statusCode == 200) {
          username = usernameController.text;
          loginState = StateLogin.success;
          notifyListeners();

          // Store JWT token
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', response.data['token']);
          await prefs.setString('username', username);

          token = response.data['token'];
        } else if (response.statusCode == 401) {
          messageError = 'Username or password is incorrect. Please try again!';
          loginState = StateLogin.error;
        } else {
          messageError = 'An error occurred. Please try again!';
          loginState = StateLogin.error;
        }
      } catch (e) {
        messageError = 'An error occurred. Please try again!';
        loginState = StateLogin.error;
      }
    } else {
      showAlertError(context);
    }

    notifyListeners();
    return null;
  }

  void actionObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? 'Nama Pengguna';
    token = prefs.getString('token') ?? '';
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('username');
    username = '';
    token = '';
    loginState = StateLogin.initial;
    notifyListeners();
  }
}

enum StateLogin { initial, success, error }

void showAlertError(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 10),
            Text('Error'),
          ],
        ),
        content: const Text(
          'Check your input fields and try again.',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'),
          ),
        ],
      );
    },
  );
}
