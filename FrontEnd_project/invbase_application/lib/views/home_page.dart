import 'package:flutter/material.dart';
import 'package:invbase_application/views/login_page.dart';
import 'package:provider/provider.dart';
import 'package:invbase_application/controllers/login_provider.dart'; // Sesuaikan dengan lokasi file LoginProvider

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return Column(
            children: [
              // Header dengan nama akun dan foto
              Container(
                color: Colors.deepPurpleAccent,
                padding: const EdgeInsets.fromLTRB(25, 50, 25, 25),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, ${loginProvider.username}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Text(
                          'Welcome to my Invbase',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      padding: const EdgeInsets.only(left: 80),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: Colors.white,
                              title: const Column(
                                children: [
                                  Icon(
                                    Icons.exit_to_app,
                                    size: 50,
                                    color: Colors.red,
                                  ),
                                  Text('Logout',
                                      style: TextStyle(color: Colors.red)),
                                ],
                              ),
                              content: const Text(
                                  'Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Tutup dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.red, // Warna latar belakang
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Tutup dialog
                                    // Implement logout logic here
                                    // Misalnya:
                                    Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .logout();
                                    // Navigasi ke halaman login setelah logout
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                      (route) =>
                                          false, // Hindari kembali ke halaman sebelumnya
                                    );
                                    // Tampilkan dialog berhasil logout (opsional)
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Logout Successful'),
                                          content:
                                              Text('You have been logged out.'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Logout',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Product ${index + 1}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      // Footer Icon Navigation
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
