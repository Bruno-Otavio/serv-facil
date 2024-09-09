import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/open_os_widget.dart';
import 'package:serv_facil/widgets/taken_os_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? colaborador;

  @override
  Widget build(BuildContext context) {
    colaborador = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
        child: FutureBuilder(
          future: OsService.getOss(token: colaborador!.token!),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final Os os = data[index];
                  if (os.executor != null &&
                      os.executor?.matricula == colaborador!.matricula) {
                    return TakenOsWidget(os: os);
                  } else {
                    return OpenOsWidget(os: os);
                  }
                },
              );
            }
          },
        ),
      ),
      drawer: Drawer(),
    );
  }
}
