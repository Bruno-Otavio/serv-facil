import 'package:flutter/material.dart';
import 'package:serv_facil/widgets/button.dart';
import 'package:serv_facil/widgets/text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  final TextEditingController _setorController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _pinConfirmationController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _matriculaController.dispose();
    _nomeController.dispose();
    _cargoController.dispose();
    _setorController.dispose();
    _pinController.dispose();
    _pinConfirmationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextInput(
                  controller: _matriculaController,
                  validator: (value) => null,
                  hintText: 'Matrícula',
                ),
                TextInput(
                  controller: _nomeController,
                  validator: (value) => null,
                  hintText: 'Nome Completo',
                ),
                TextInput(
                  controller: _cargoController,
                  validator: (value) => null,
                  hintText: 'Cargo',
                ),
                TextInput(
                  controller: _setorController,
                  validator: (value) => null,
                  hintText: 'Setor',
                ),
                TextInput(
                  controller: _pinController,
                  validator: (value) => null,
                  hintText: 'PIN',
                ),
                TextInput(
                  controller: _pinConfirmationController,
                  validator: (value) => null,
                  hintText: 'Confirme seu PIN',
                ),
                Button(onTap: () {}, text: 'Cadastrar')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
