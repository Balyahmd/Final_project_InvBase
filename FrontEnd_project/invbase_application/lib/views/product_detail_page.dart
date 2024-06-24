import 'package:flutter/material.dart';
import 'package:invbase_application/controllers/product_provider.dart';
import 'package:invbase_application/views/home_page.dart';
import 'package:provider/provider.dart';
import 'package:invbase_application/models/product_model.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<ProductProvider>(context, listen: false)
        .getProductById(widget.productId));
  }

  String formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.deepPurpleAccent,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.state == ProductState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state == ProductState.error) {
            return Center(child: Text(provider.messageError));
          } else if (provider.state == ProductState.success &&
              provider.listProduct != null) {
            ProductData product = provider.listProduct!
                .firstWhere((prod) => prod.id == widget.productId);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product.imageUrl ?? '', fit: BoxFit.cover),
                  const SizedBox(height: 16.0),
                  Text(
                    product.name ?? 'No Name',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Quantity: ${product.qty ?? 0}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8.0),
                  if (product.category != null)
                    Text('Category: ${product.category!.name}',
                        style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8.0),
                  if (product.user != null)
                    Text('Author by: ${product.user!.username}',
                        style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 16.0),
                  Text('Created At: ${formatDate(product.createdAt)}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8.0),
                  Text('Updated At: ${formatDate(product.updatedAt)}',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
