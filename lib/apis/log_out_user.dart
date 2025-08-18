import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class LogOutUser {
  final storage = const FlutterSecureStorage();
  Future<String?> readSecureValue({required String key}) async {
    return await storage.read(key: key);
  }

  void logOutUser() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/logout_user');
    String? token = await readSecureValue(key: 'token');
    var response = await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 202 || response.statusCode == 201) {
      print('log out done successfully \n body=${response.body}');
    } else {
      print(
        'log out failed \n statusCode=${response.statusCode} \n body=${response.body}',
      );
    }
  }
}
