import 'package:flutter/material.dart';
import 'package:invbase_application/controllers/bottom_navigation_provider.dart';
import 'package:invbase_application/controllers/category_provider.dart';
import 'package:invbase_application/controllers/product_provider.dart';
import 'package:invbase_application/views/splash_screen.dart';
import 'package:provider/provider.dart';
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
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
