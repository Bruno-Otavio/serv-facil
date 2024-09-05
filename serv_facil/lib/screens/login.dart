import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset('assets/icone.png', height: 150,),
                  const SizedBox(height: 10),
                  Image.asset('assets/logomarca.png', width: 250,),
                ]
              ),
            ),
            Column(
              children: [
                TextFormField(
                  validator: (value) => null,
                  controller: _matriculaController,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
