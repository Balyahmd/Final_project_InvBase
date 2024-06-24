import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:invbase_application/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invbase_application/server/config.dart';

class ProductProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  List<ProductData>? listProduct;
  var state = ProductState.initial;
  var messageError = '';
  var BaseUrl = Config.baseUrl;

  int idDataSelected = 0;

  ProductProvider() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getToken();
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ));
  }

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> getAllProducts() async {
    state = ProductState.loading;
    notifyListeners();

    try {
      var response = await _dio.get(
        '${BaseUrl}/product/',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      var result = ProductModel.fromJson(response.data);
      if (result.data == null || result.data!.isEmpty) {
        state = ProductState.nodata;
      } else {
        state = ProductState.success;
        listProduct = result.data;
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 500) {
        messageError = 'Server error: ${e.response!.statusMessage}';
      } else {
        messageError = 'Failed to fetch data: ${e.message}';
      }
      state = ProductState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = ProductState.error;
    }
    notifyListeners();
  }

  Future<void> getProductById(int id) async {
    state = ProductState.loading;
    notifyListeners();

    try {
      var response = await _dio.get(
        '${BaseUrl}/product/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      var result = ProductData.fromJson(response.data);
      state = ProductState.success;
      listProduct ??= [];
      listProduct!.add(result);
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        messageError = 'Product not found';
      } else {
        messageError = 'Failed to fetch product: ${e.message}';
      }
      state = ProductState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = ProductState.error;
    }
    notifyListeners();
  }

  Future<void> addProduct({
    required String name,
    required int qty,
    required String imageUrl,
    required int categoryId,
  }) async {
    state = ProductState.loading;
    notifyListeners();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId') ??
          0; // Assuming userId is stored in SharedPreferences

      var response = await _dio.post(
        '${BaseUrl}/product/add',
        data: {
          'name': name,
          'qty': qty,
          'imageUrl': imageUrl,
          'createdBy': userId,
          'updatedBy': userId,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      var result = ProductData.fromJson(response.data);
      state = ProductState.success;
      listProduct ??= [];
      listProduct!.add(result);
    } on DioError catch (e) {
      messageError = 'Failed to add product: ${e.message}';
      state = ProductState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = ProductState.error;
    }
    notifyListeners();
  }

  Future<void> updateProduct({
    required int id,
    required String name,
    required int qty,
    required String imageUrl,
    required int categoryId,
  }) async {
    state = ProductState.loading;
    notifyListeners();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId') ??
          0; // Assuming userId is stored in SharedPreferences

      var response = await _dio.put(
        '${BaseUrl}/product/update/$id',
        data: {
          'name': name,
          'qty': qty,
          'imageUrl': imageUrl,
          'updatedBy': userId,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        state = ProductState.success;
        var updatedProduct =
            listProduct?.firstWhere((product) => product.id == id);
        if (updatedProduct != null) {
          updatedProduct.name = name;
          updatedProduct.qty = qty;
          updatedProduct.imageUrl = imageUrl;
        }
      } else {
        messageError = 'Failed to update product';
        state = ProductState.error;
      }
    } on DioError catch (e) {
      messageError = 'Failed to update product: ${e.message}';
      state = ProductState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = ProductState.error;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    state = ProductState.loading;
    notifyListeners();

    try {
      var response = await _dio.delete(
        '${BaseUrl}/product/delete/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        state = ProductState.success;
        listProduct?.removeWhere((product) => product.id == id);
      } else {
        messageError = 'Failed to delete product';
        state = ProductState.error;
      }
    } on DioError catch (e) {
      messageError = 'Failed to delete product: ${e.message}';
      state = ProductState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = ProductState.error;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}

enum ProductState { initial, loading, success, error, nodata }
