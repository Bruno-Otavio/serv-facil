import 'dart:convert';

import 'package:serv_facil/constants.dart';
import 'package:serv_facil/models/os.dart';
import 'package:http/http.dart' as http;

class OsService {
  static Future<List<Os>> getOss({ required String token}) async {
    final headers = <String, String>{
      'authorization': token,
    };
    final response = await http.get(Uri.parse('$apiUrl/os'), headers: headers);   

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body) as List;
      return body.map((e) => Os.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch Oss.');
    }
  }
}