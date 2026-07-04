import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:grand_library/core/constants/api_constants.dart';
import 'package:grand_library/core/services/dio_client.dart';
import 'package:grand_library/features/dashboard/data/models/product_model.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  ProductStatus _status = ProductStatus.initial;
  List<ProductModel> _products = [];
  String? _error;

  ProductStatus get status => _status;
  List<ProductModel> get products => _products;
  String? get error => _error;
  bool get isLoading => _status == ProductStatus.loading;

  Future<void> fetchProducts() async {
    _status = ProductStatus.loading;
    notifyListeners();

    try {
      final response = await DioClient.instance.get(ApiConstants.products);

      // ==========================
      // DEBUG RESPONSE DARI BACKEND
      // ==========================
      print("========== RESPONSE ==========");
      print(const JsonEncoder.withIndent('  ').convert(response.data));
      print("==============================");

      final List<dynamic> data = response.data['data'];

      // Print setiap item produk
      for (var item in data) {
        print("PRODUCT => $item");
      }

      _products = data.map((e) {
        print("PARSING => $e");
        return ProductModel.fromJson(e);
      }).toList();

      _status = ProductStatus.loaded;
    } on DioException catch (e) {
      print("DIO ERROR : ${e.response?.data}");

      _error = e.response?.data['message'] ?? 'Gagal memuat produk';
      _status = ProductStatus.error;
    } catch (e, stackTrace) {
      print("GENERAL ERROR : $e");
      print(stackTrace);

      _error = e.toString();
      _status = ProductStatus.error;
    }

    notifyListeners();
  }
}
