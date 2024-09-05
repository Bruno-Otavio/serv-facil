import 'dart:convert';

import 'package:serv_facil/constants.dart';
import 'package:serv_facil/model/user.dart';
import 'package:http/http.dart' as http;


class UserService {
  static Future<User> login({ required String matricula, required String pin, }) async {
    final data = <String, dynamic>{
      'matricula': matricula,
      'pin': pin,
    };

    final headers = <String, String>{
      'content-type': 'application/json',
    };

    final response = await http.post(Uri.parse('$apiUrl/login'), body: jsonEncode(data), headers: headers);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Invalid matricula or PIN.');
    }
  }
}