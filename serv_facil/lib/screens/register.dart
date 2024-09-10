import 'package:flutter/material.dart';
import 'package:serv_facil/widgets/UI/button.dart';
import 'package:serv_facil/widgets/UI/outlinedd_button.dart';
import 'package:serv_facil/widgets/UI/text_input.dart';

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
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              TextInput(
                validator: (value) => null,
                controller: _matriculaController,
                text: 'Matrícula',
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
              TextInput(
                validator: (value) => null,
                controller: _nomeController,
                text: 'Nome',
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
              TextInput(
                validator: (value) => null,
                controller: _cargoController,
                text: 'Cargo',
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
              TextInput(
                validator: (value) => null,
                controller: _pinController,
                text: 'PIN',
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
              TextInput(
                validator: (value) => null,
                controller: _confirmPinController,
                text: 'Confirme seu PIN',
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
              Button(
                onPressed: () {},
                text: 'Cadastrar',
                color: Theme.of(context).colorScheme.tertiary,
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
              OutlineddButton(
                onPressed: () {},
                text: 'Já possui um cadastro?',
                margin: const EdgeInsets.symmetric(vertical: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
