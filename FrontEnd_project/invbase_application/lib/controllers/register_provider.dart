import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:invbase_application/models/authRequest_model.dart';
import 'package:invbase_application/server/config.dart';

class RegisterProvider extends ChangeNotifier {
  var formKeyRegister = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var registerState = StateRegister.initial;
  var username = '';
  var messageError = '';
  bool obscurePassword = true;
  final Dio _dio = Dio();
  var BaseUrl = Config.baseUrl;

  Future<String?> processRegister(BuildContext context) async {
    if (formKeyRegister.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        try {
          AuthRequestModel requestModel = AuthRequestModel(
            username: usernameController.text,
            password: passwordController.text,
          );

          final response = await _dio.post(
            '${BaseUrl}/auth/register',
            data: requestModel.toJson(),
          );

          if (response.statusCode == 201) {
            username = usernameController.text;
            registerState = StateRegister.success;
            notifyListeners();
          } else if (response.statusCode == 402) {
            messageError = 'Username already exists!';
            registerState = StateRegister.error;
          } else {
            messageError = 'Registration failed. Please try again!';
            registerState = StateRegister.error;
          }
        } catch (e) {
          messageError = 'An error occurred. Please try again!';
          registerState = StateRegister.error;
        }
      } else {
        messageError = 'Passwords do not match. Please try again!!!';
        registerState = StateRegister.error;
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
}

enum StateRegister { initial, success, error }

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
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}

void showRegisterAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20), // Ubah nilai sesuai preferensi Anda
        ),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 10),
            Text('Registration Failed'),
          ],
        ),
        content: const Text(
          'Email has been registered!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10), // Ubah nilai sesuai preferensi Anda
              ),
              backgroundColor: Colors.orange,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
