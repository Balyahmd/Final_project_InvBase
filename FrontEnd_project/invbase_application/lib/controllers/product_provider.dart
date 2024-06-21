import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:invbase_application/models/product_model.dart';
import 'package:invbase_application/models/product_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController imageUrl = TextEditingController();

  List<DataResponse>? listProduct;
  var state = ProductState.initial;
  var messageError = '';

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

  Future<void> getProduct() async {
    state = ProductState.loading;
    notifyListeners();

    try {
      var response = await _dio.get('http://192.168.1.7:3000/product/');
      var result = ProductModel.fromJson(response.data);
      if (result.data!.isEmpty) {
        state = ProductState.nodata;
      } else {
        state = ProductState.success;
        listProduct = result.data?.cast<DataResponse>();
      }
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

  // Example method to handle logout and clear JWT token
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // Optionally clear other data or perform additional logout tasks
  }
}

enum ProductState { initial, loading, success, error, nodata }
