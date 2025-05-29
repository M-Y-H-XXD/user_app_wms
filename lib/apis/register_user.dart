import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:wms/static_classes/user_informations.dart';

class RegisterUser {
  //final String host = '10.0.2.2';
  final storage = const FlutterSecureStorage();
  Future<void> saveSecureValue({
    required String key,
    required String? value,
  }) async {
    await storage.write(key: key, value: value);
  }

  Future<Response> registerUser() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/register_user');
    Map requestData = {
      'email': UserInformations.email,
      'password': UserInformations.password,
      'phone_number': UserInformations.phoneNumber,
    };
    var response = await post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      await saveSecureValue(key: 'token', value: data['token']);
      print('register done successfully \n body=${response.body}');
      return response;
    } else {
      print(
        'register failed \n statusCode=${response.statusCode} \n body=${response.body}',
      );
      return response;
    }
  }
}
