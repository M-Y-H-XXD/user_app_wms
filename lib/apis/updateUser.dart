import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:wms/static_classes/updateUser_data.dart';

class Updateuser {
  String? _token;
  final storage = const FlutterSecureStorage();
  Future<String?> _readSecureValue({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> _fetchData() async {
    _token = await _readSecureValue(key: 'token');
  }

  Future<void> updateuserMethod({
    required String? name,
    required String? lastName,
    required String? loacation,
    required String? password,
  }) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/updateUser');

    await _fetchData();
    final Map<String, dynamic> requestData = {
      "name": "$name",
      "last_name": "$lastName",
      "location": "$loacation",

      "password": "$password",
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
        UpdateuserData.updateuserMap = {};
        UpdateuserData.updateuserMap.addAll(data);
        print('Updateuser sent successfully:${response.body}');
      } else {
        print('Failed to sent Updateuser Status code: ${response.statusCode}');
        UpdateuserData.updateuserMap = {};
        UpdateuserData.updateuserMap.addAll(data);
        print('Response body: ${response.body}');
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in Updateuser: $e');
    }
  }
}
