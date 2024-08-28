import 'dart:convert';

import 'package:serv_facil/constants.dart';
import 'package:serv_facil/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<User> login({
    required String matricula,
    required String pin,
  }) async {
    final data = <String, dynamic>{
      'matricula': matricula,
      'pin': pin,
    };
    final response = await http.post(Uri.parse('$apiUrl/login'), body: jsonEncode(data));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else if (response.statusCode == 401) {
      throw Exception('Matrícula ou PIN inválidos.');
    } else {
      throw Exception('Could not authenticate.');
    }
  }
}
