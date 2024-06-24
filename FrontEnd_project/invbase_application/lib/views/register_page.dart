// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invbase_application/views/login_page.dart';
import 'package:invbase_application/controllers/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form(
            key: registerProvider.formKeyRegister,
            child: ListView(
              children: [
                SizedBox(
                  child: SvgPicture.asset(
                    "lib/assets/icons/Inventory_base_logo.svg",
                    width: 150,
                    height: 150,
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
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Register to Your account!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                  controller: registerProvider.usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the Username correctly';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Input Your Username',
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
                Consumer<RegisterProvider>(
                  builder: (context, registerProvider, child) {
                    return TextFormField(
                      controller: registerProvider.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill the Password correctly';
                        }
                        return null;
                      },
                      obscureText: registerProvider.obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Input Your Password',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 25, 20, 34),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.deepPurple,
                        ),
                        suffixIcon: IconButton(
                          onPressed: registerProvider.actionObscurePassword,
                          icon: Icon(
                            registerProvider.obscurePassword
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
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<RegisterProvider>(
                  builder: (context, registerProvider, child) {
                    return TextFormField(
                      controller: registerProvider.confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your Password';
                        } else if (value !=
                            registerProvider.passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      obscureText: registerProvider.obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Your Password',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 25, 20, 34),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.deepPurple,
                        ),
                        suffixIcon: IconButton(
                          onPressed: registerProvider.actionObscurePassword,
                          icon: Icon(
                            registerProvider.obscurePassword
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
                Consumer<RegisterProvider>(
                  builder: (context, registerProvider, child) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 82, 16, 195),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () async {
                        if (registerProvider.formKeyRegister.currentState!
                            .validate()) {
                          await registerProvider.processRegister(context);
                          if (registerProvider.registerState ==
                              StateRegister.success) {
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
                                      Text('Register Successful'),
                                    ],
                                  ),
                                  content: Text(
                                      'Successfully registered as ${registerProvider.usernameController.text}'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(color: Colors.white),
                                      ),
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
                              "Register",
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
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Already have an account?  ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login now!',
                          style: TextStyle(
                            fontSize: 14,
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
            Text('Failed Register'),
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
                borderRadius: BorderRadius.circular(
                    10), // Ubah nilai sesuai preferensi Anda
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
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.orange,
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
