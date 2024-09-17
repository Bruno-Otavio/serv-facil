import 'package:flutter/material.dart';
import 'package:serv_facil/widgets/UI/form_widgets/button.dart';
import 'package:serv_facil/widgets/UI/form_widgets/text_input.dart';

class AddCommentScreen extends StatelessWidget {
  AddCommentScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextInput(validator: (value) => null, controller: _controller, text: 'Insira seu comentário'),
          Button(onPressed: onPressed, text: text, color: color)
        ],
      ),
    );
  }
}