import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invbase_application/controllers/login_provider.dart';
import 'package:invbase_application/views/home_page.dart';
import 'package:invbase_application/views/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Form(
            key: loginProvider.formKeyLogin,
            child: ListView(
              children: [
                SizedBox(
                  child: SvgPicture.asset(
                    "lib/assets/icons/Inventory_base_logo.svg",
                    width: 160,
                    height: 160,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text.rich(
                  TextSpan(
                    text: 'Welcome Back 👋 to',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Inventory Base',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 82, 16, 195),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Login to Your account!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: loginProvider.usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the Email correctly';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Input Your Email',
                    labelStyle: TextStyle(color: Colors.deepPurple),
                    prefixIcon: Icon(Icons.person, color: Colors.deepPurple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return TextFormField(
                      controller: loginProvider.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the Password correctly';
                        }
                        return null;
                      },
                      obscureText: loginProvider.obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Input Your Password',
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.deepPurple,
                        ),
                        suffixIcon: IconButton(
                          onPressed: loginProvider.actionObscurePassword,
                          icon: Icon(
                            loginProvider.obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 82, 16, 195),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () async {
                        if (loginProvider.formKeyLogin.currentState!
                            .validate()) {
                          await loginProvider.processLogin(context);
                          // print(loginProvider.loginState);
                          if (loginProvider.loginState == StateLogin.success) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: const Row(
                                    children: [
                                      Icon(Icons.check_circle,
                                          color: Colors.green),
                                      SizedBox(width: 10),
                                      Text('Login Successful'),
                                    ],
                                  ),
                                  content: Text(
                                      'Successfully Login as ${loginProvider.usernameController.text}'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            showAlertError(context);
                          }
                        } else {
                          showAlertError(context);
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register now!',
                          style: TextStyle(
                            color: Color.fromARGB(255, 82, 16, 195),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertError(BuildContext context) {
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
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 10),
            Text('Login Failed'),
          ],
        ),
        content: const Text(
          'Check your email and password!',
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
            child: const Text('Ok', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
