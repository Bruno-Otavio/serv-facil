import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/models/os.dart';
import 'package:serv_facil/models/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/os/os_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Ordens de Serviço',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Image.asset(
            'assets/icone.png',
            height: 45,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: OsService.getOss(token: user!.token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(itemCount: data.length, itemBuilder: (context, index) {
                final Os os = data[index];
                return OsItem(os: os);
              });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      drawer: Drawer(),
    );
  }
}
