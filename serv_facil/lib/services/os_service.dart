import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serv_facil/constants.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/services/user_service.dart';

class OsService {
  static Future<List<Os>> getOss({required String token}) async {
    final response = await http.get(
      Uri.parse('$apiUrl/os'),
      headers: {
        'authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);

      for (Map data in body) {
        final User colaborador = await UserService.getColaborador(token: token, id: data['colaborador']);

        if (data['executor'] != null) {
          final User executor = await UserService.getColaborador(token: token, id: data['executor']);
          data.update('executor', (value) => executor);
        }
        data.update('colaborador', (value) => colaborador);
      }

      return body.map((e) => Os.fromJson(e)).toList();
    } else {
      throw Exception('Could not get Oss.');
    }
  }
}
