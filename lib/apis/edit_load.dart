import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:wms/static_classes/edit_load_data.dart';

class EditLoad {
  String? _token;
  final storage = const FlutterSecureStorage();
  Future<String?> _readSecureValue({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> _fetchData() async {
    _token = await _readSecureValue(key: 'token');
  }

  Future<Response?> editLoadMethod({
    required int loadID,
    required int quantity,
  }) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/edit_load');

    await _fetchData();
    final Map<String, dynamic> requestData = {
      "load_id": "$loadID",
      "quantity": "$quantity",
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
        EditLoadData.editLoadMap = {};
        print('data=$data');
        EditLoadData.editLoadMap.addAll(data);
        print('EditLoad sent successfully:${response.body}');
        return response;
      } else {
        print('Failed to sent EditLoad Status code: ${response.statusCode}');
        EditLoadData.editLoadMap = {};

        EditLoadData.editLoadMap.addAll(data);

        print('Response body: ${response.body}');
        return response;
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in EditLoad: $e');
    }
    return null;
  }
}
