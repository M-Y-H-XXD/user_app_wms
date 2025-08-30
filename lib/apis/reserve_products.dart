import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:wms/constants_components/status_of_transfer.dart';
import 'package:wms/constants_components/type_of_transfer.dart';
import 'package:wms/static_classes/reserve_products_data.dart';

class ReserveProducts {
  String? _token;
  final storage = const FlutterSecureStorage();
  Future<String?> _readSecureValue({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> _fetchData() async {
    _token = await _readSecureValue(key: 'token');
  }

  Future<Response?> reserveProductsMethod({
    required int distributionCenterId,
    required Map<String, String> order, //{id,quantity}
    required String location,
    required double latitude,
    required double longitude,
    required TypeOfTransfer typeOfTransfer,
    required StatusOfTransfer statusOfTransfer,
  }) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/reserve_products');

    await _fetchData();
    final Map<String, dynamic> requestData = {
      "dist_c_id": distributionCenterId,
      "order": order,

      "location": location,
      "latitude": latitude,
      "longitude": longitude,
      "type": typeOfTransfer.name,
      "status": statusOfTransfer.name,
    };
    try {
      final response = await post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode(requestData),
      );
      Map<dynamic, dynamic> data = json.decode(response.body);
      if (response.statusCode == 202 || response.statusCode == 201) {
        ReserveProductsData.reserveProductsMap = {};
        ReserveProductsData.reserveProductsMap.addAll(data);

        print('ReserveProducts sent successfully:${response.body}');
        return response;
      } else {
        print(
          'Failed to sent ReserveProducts Status code: ${response.statusCode}',
        );
        ReserveProductsData.reserveProductsMap = {};
        ReserveProductsData.reserveProductsMap.addAll(data);
        print('Response body: ${response.body}');
        return response;
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in ReserveProducts: $e');
    }
    return null;
  }
}
