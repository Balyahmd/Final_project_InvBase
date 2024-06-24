// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:invbase_application/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:invbase_application/server/config.dart';

class CategoryProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List<CategoryModel>? categories;
  var state = CategoryState.initial;
  var messageError = '';
  var BaseUrl = Config.baseUrl;

  CategoryProvider() {
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

  Future<void> getAllCategories() async {
    state = CategoryState.loading;
    notifyListeners();

    try {
      var response = await _dio.get(
        '${BaseUrl}/category/',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      categories = (response.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      state = CategoryState.success;
    } on DioError catch (e) {
      if (e.response != null && e.response!.statusCode == 500) {
        messageError = 'Server error: ${e.response!.statusMessage}';
      } else {
        messageError = 'Failed to fetch data: ${e.message}';
      }
      state = CategoryState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = CategoryState.error;
    }
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    state = CategoryState.loading;
    notifyListeners();

    try {
      var response = await _dio.post(
        '${BaseUrl}/category/add',
        data: {'name': name},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        state = CategoryState.success;
        var newCategory = CategoryModel.fromJson(response.data);
        categories?.add(newCategory);
      } else {
        messageError = 'Failed to add category';
        state = CategoryState.error;
      }
    } on DioError catch (e) {
      messageError = 'Failed to add category: ${e.message}';
      state = CategoryState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = CategoryState.error;
    }
    notifyListeners();
  }

  Future<void> updateCategory(int id, String name) async {
    state = CategoryState.loading;
    notifyListeners();

    try {
      var response = await _dio.put(
        '${BaseUrl}/category/update/$id',
        data: {'name': name},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        state = CategoryState.success;
        var updatedCategory = categories?.firstWhere((cat) => cat.id == id);
        if (updatedCategory != null) {
          updatedCategory.name = name;
        }
      } else {
        messageError = 'Failed to update category';
        state = CategoryState.error;
      }
    } on DioError catch (e) {
      messageError = 'Failed to update category: ${e.message}';
      state = CategoryState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = CategoryState.error;
    }
    notifyListeners();
  }

  Future<void> deleteCategory(int id) async {
    state = CategoryState.loading;
    notifyListeners();

    try {
      var response = await _dio.delete(
        '${BaseUrl}/category/delete/$id',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        state = CategoryState.success;
        categories?.removeWhere((cat) => cat.id == id);
      } else {
        messageError = 'Failed to delete category';
        state = CategoryState.error;
      }
    } on DioError catch (e) {
      messageError = 'Failed to delete category: ${e.message}';
      state = CategoryState.error;
    } catch (e) {
      messageError = 'An unexpected error occurred: ${e.toString()}';
      state = CategoryState.error;
    }
    notifyListeners();
  }
}

enum CategoryState { initial, loading, success, error }
