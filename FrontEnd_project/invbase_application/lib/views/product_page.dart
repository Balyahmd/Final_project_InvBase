import 'package:flutter/material.dart';
import 'package:invbase_application/controllers/bottom_navigation_provider.dart';
import 'package:invbase_application/controllers/category_provider.dart';
import 'package:invbase_application/controllers/product_provider.dart';
import 'package:invbase_application/models/product_response_model.dart';
import 'package:invbase_application/views/home_page.dart';
import 'package:invbase_application/views/profile_page.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<CategoryProvider>(context, listen: false).getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(color: Colors.deepPurpleAccent),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Slider Filter Category
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Filter by Category'),
                Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, _) {
                    return Slider(
                      value: (_selectedCategoryId ?? 1).toDouble(),
                      min: 1,
                      max: categoryProvider.categories!.length.toDouble(),
                      divisions: categoryProvider.categories?.length,
                      label: _selectedCategoryId != null
                          ? categoryProvider.categories
                              ?.firstWhere(
                                  (cat) => cat.id == _selectedCategoryId)
                              .name
                          : '',
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value.round();
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                if (provider.state == ProductState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.state == ProductState.error) {
                  return Center(child: Text(provider.messageError));
                } else if (provider.state == ProductState.nodata) {
                  return const Center(child: Text('No Data'));
                } else if (provider.state == ProductState.success) {
                  var filteredProducts = _selectedCategoryId != null
                      ? provider.listProduct
                          ?.where((product) =>
                              product.category?.id == _selectedCategoryId)
                          .toList()
                      : provider.listProduct;

                  return ListView.builder(
                    itemCount: filteredProducts?.length ?? 0,
                    itemBuilder: (context, index) {
                      var product = filteredProducts![index];

                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: product.imageUrl != null
                                        ? Image.network(
                                            product.imageUrl!,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(
                                                Icons.image,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                        'Category: ${product.category?.name ?? 'Unknown'}'),
                                    const SizedBox(height: 8),
                                    Text('Quantity: ${product.qty ?? 0}'),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.amberAccent),
                                onPressed: () {
                                  // _navigateToEditProduct(product);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(
                                      product.id ?? 0);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container(); // Fallback
              },
            ),
          ),
        ],
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

  void _deleteProduct(int id) {
    Provider.of<ProductProvider>(context, listen: false).deleteProduct(id);
  }

  Future<void> _showDeleteConfirmationDialog(int productId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this product?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteProduct(productId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
