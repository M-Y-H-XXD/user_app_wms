import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:wms/static_classes/delete_invoice_data.dart';

class DeleteInvoice {
  String? _token;

  final storage = const FlutterSecureStorage();
  Future<String?> _readSecureValue({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> _fetchData() async {
    _token = await _readSecureValue(key: 'token');
  }

  Future<Response?> deleteInvoiceMethod({required int invoiceId}) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/delete_invoice/$invoiceId');

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
        DeleteInvoiceData.deleteInvoiceMap = {};
        DeleteInvoiceData.deleteInvoiceMap.addAll(data);
        print('DeleteInvoice sent successfully:${response.body}');
        return response;
      } else {
        print(
          'Failed to sent DeleteInvoice Status code: ${response.statusCode}',
        );
        DeleteInvoiceData.deleteInvoiceMap = {};
        DeleteInvoiceData.deleteInvoiceMap.addAll(data);
        print('Response body: ${response.body}');
        return response;
      }
    } on FormatException catch (e) {
      print('Invalid JSON response: $e\nResponse body: ');
    } catch (e) {
      print('An error occurred in DeleteInvoice: $e');
    }
    return null;
  }
}
