import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:wms/static_classes/show_products_in_centers_data.dart';

class ShowProductsInCenters {
  String? _token;

  final storage = const FlutterSecureStorage();
  Future<String?> _readSecureValue({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> _fetchData() async {
    _token = await _readSecureValue(key: 'token');
  }

  Future<void> showProductsInCentersMethod() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/show_products_in_centers');

    await _fetchData();

    try {
      final response = await get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );
      Map<dynamic, dynamic> data = json.decode(response.body);
      if (response.statusCode == 202 || response.statusCode == 201) {
        ShowProductsInCentersData.showProductsInCentersMap = {};
        ShowProductsInCentersData.showProductsInCentersMap.addAll(data);
        print('ShowProductsInCenters sent successfully:${response.body}');
      } else {
        print(
          'Failed to sent ShowProductsInCenters Status code: ${response.statusCode}',
        );
        ShowProductsInCentersData.showProductsInCentersMap = {};
        ShowProductsInCentersData.showProductsInCentersMap.addAll(data);
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in ShowProductsInCenters: $e');
    }
  }
}
