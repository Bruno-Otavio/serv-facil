import 'package:flutter/material.dart';
import 'package:serv_facil/model/os.dart';

class OsProvider with ChangeNotifier {
  Future<List<Os>>? _futureOs;
}