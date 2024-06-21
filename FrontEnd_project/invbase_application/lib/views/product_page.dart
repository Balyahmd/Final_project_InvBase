import 'package:flutter/material.dart';
import 'package:invbase_application/controllers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    // Fetch product data when the widget is initialized
    Provider.of<ProductProvider>(context, listen: false).getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header dengan nama akun dan foto
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                ),
                SizedBox(width: 16),
                Text(
                  'Nama Akun',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Slider Category
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'Category ${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }),
            ),
          ),
          // List Product dengan shadow box
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
                  return ListView.builder(
                    itemCount: provider.listProduct?.length ?? 0,
                    itemBuilder: (context, index) {
                      var product = provider.listProduct![index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name ?? '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('Quantity: ${product.qty}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      // Footer Icon Navigation
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
