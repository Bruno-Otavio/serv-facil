import 'dart:convert';

import 'package:serv_facil/constants.dart';
import 'package:serv_facil/models/os.dart';
import 'package:http/http.dart' as http;
import 'package:serv_facil/models/user.dart';

class OsService {
  static Future<List<Os>> getOss({required String token}) async {
    final headers = <String, String>{
      'authorization': token,
    };
    final response = await http.get(Uri.parse('$apiUrl/os'), headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List;

      for (Map<String, dynamic> os in body) {
        final futureColaborador = await http.get(
          Uri.parse('$apiUrl/colaborador/${os['colaborador']}'),
          headers: headers,
        );

        final futureExecutor = await http.get(
          Uri.parse('$apiUrl/colaborador/${os['executor']}'),
          headers: headers,
        );
        if (futureExecutor.statusCode == 200 ||
            futureColaborador.statusCode == 200) {
          final User colaborador = User.fromJson(
            jsonDecode(futureColaborador.body) as Map<String, dynamic>,
          );
          final User? executor;
          if (jsonDecode(futureExecutor.body) != null) {
            executor = User.fromJson(
                jsonDecode(futureExecutor.body) as Map<String, dynamic>);
            os.update('executor', (value) => executor);
          }

          os.update('colaborador', (value) => colaborador);
        }
      }

      return body.map((e) => Os.fromJson(e)).toList();
    } else {
      throw Exception('Could not fetch Oss.');
    }
  }

  static Future<void> addOs({
    required User colaborador,
    required String descricao,
  }) async {
    final data = <String, dynamic>{
      'descricao': descricao,
      'colaborador': colaborador.matricula,
    };

    final headers = <String, String>{
      'authorization': colaborador.token!,
    };

    final response = await http.post(Uri.parse('$apiUrl/os'), body: jsonEncode(data), headers: headers);

    if (response.statusCode != 201) {
      throw Exception('Could not create new OS.');
    }
  }
}
