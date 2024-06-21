import 'package:flutter/material.dart';
import 'package:invbase_application/controllers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:invbase_application/views/register_page.dart';
import 'package:invbase_application/controllers/login_provider.dart';
import 'package:invbase_application/controllers/register_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            RegisterPage(), // Change this to RegisterPage() to start with the registration page
      ),
    );
  }
}
