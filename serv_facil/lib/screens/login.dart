import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/main.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/user_service.dart';
import 'package:serv_facil/widgets/UI/button.dart';
import 'package:serv_facil/widgets/UI/outlinedd_button.dart';
import 'package:serv_facil/widgets/UI/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  void _login() async {
    try {
      final User colaborador = await UserService.login(
        matricula: _matriculaController.text,
        pin: _pinController.text,
      );
      Provider.of<UserProvider>(context, listen: false).user = colaborador;
      navigatorKey.currentState?.pushReplacementNamed('/home');
    } catch (e) {
      print('invalid matricula or pin');
    }
  }

  @override
  void initState() {
    super.initState();
    _matriculaController.text == '200';
    _pinController.text == '1234';
  }

  @override
  void dispose() {
    super.dispose();
    _matriculaController.dispose();
    _pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: Column(children: [
                    Image.asset(
                      'assets/icone.png',
                      height: 150,
                    ),
                    const SizedBox(height: 10),
                    Image.asset(
                      'assets/logomarca.png',
                      width: 250,
                    ),
                  ]),
                ),
              ),
              Column(
                children: [
                  TextInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua matrícula.';
                      }
                      return null;
                    },
                    controller: _matriculaController,
                    text: 'Matrícula',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  TextInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu PIN.';
                      }
                      return null;
                    },
                    controller: _pinController,
                    text: 'PIN',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  Button(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    text: 'Entrar',
                    color: Theme.of(context).colorScheme.tertiary,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ],
              ),
              OutlineddButton(
                onPressed: () {},
                text: 'Cadastre-se',
                margin: const EdgeInsets.only(top: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
