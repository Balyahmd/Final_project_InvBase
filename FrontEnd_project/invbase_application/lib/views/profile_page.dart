import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invbase_application/controllers/bottom_navigation_provider.dart';
import 'package:invbase_application/server/config.dart';
import 'package:invbase_application/views/home_page.dart';
import 'package:invbase_application/views/product_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      return;
    }

    const String apiUrl = '${Config.baseUrl}/upload';

    try {
      String fileName = _imageFile!.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image':
            await MultipartFile.fromFile(_imageFile!.path, filename: fileName),
      });

      var response = await Dio().post(apiUrl, data: formData);
      // Handle success or error accordingly
      print('Upload success! Response: ${response.data}');
    } catch (e) {
      print('Upload failed: $e');
      // Handle upload failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null) ...[
              Image.file(_imageFile!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadImage,
                child: const Text('Upload Image'),
              ),
            ] else ...[
              const Text('No image selected'),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text('Choose Image'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavigationBarProvider>(
        builder: (context, provider, child) => BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: (index) {
            provider.setIndex(index);
            // Handle navigation logic here based on index
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                break;
              case 1:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductPage()),
                );
                break;
              case 2:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                break;
              default:
                break;
            }
          },
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
      ),
    );
  }
}
