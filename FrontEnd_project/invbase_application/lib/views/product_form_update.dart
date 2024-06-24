import 'package:flutter/material.dart';
import 'package:invbase_application/controllers/category_provider.dart';
import 'package:invbase_application/controllers/product_provider.dart';
import 'package:invbase_application/models/category_model.dart';
import 'package:invbase_application/models/product_model.dart';
import 'package:invbase_application/views/home_page.dart';
import 'package:provider/provider.dart';

class ProductFormUpdate extends StatefulWidget {
  final ProductModel product;

  const ProductFormUpdate({super.key, required this.product});

  @override
  State<ProductFormUpdate> createState() => _ProductFormUpdateState();
}

class _ProductFormUpdateState extends State<ProductFormUpdate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _qtyController;
  late TextEditingController _imageUrlController;
  int? _selectedCategoryId;
  List<CategoryModel> _categories = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _qtyController = TextEditingController(text: widget.product.qty.toString());
    _imageUrlController = TextEditingController(text: widget.product.imageUrl);
    _selectedCategoryId = widget.product.categoryId;

    // Fetch categories using provider
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      await Provider.of<CategoryProvider>(context, listen: false)
          .getAllCategories();
      setState(() {
        _categories =
            Provider.of<CategoryProvider>(context, listen: false).categories ??
                [];
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qtyController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter image URL';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<int>(
                value: _selectedCategoryId,
                onChanged: (value) {
                  setState(() {
                    _selectedCategoryId = value;
                  });
                },
                items: _categories
                    .map((category) => DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(category.name),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Update product using provider
                    Provider.of<ProductProvider>(context, listen: false)
                        .updateProduct(
                      id: widget.product.id,
                      name: _nameController.text.trim(),
                      qty: int.parse(_qtyController.text.trim()),
                      imageUrl: _imageUrlController.text.trim(),
                      categoryId: _selectedCategoryId!,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                },
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
