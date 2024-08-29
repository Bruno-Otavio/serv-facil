import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/models/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/button.dart';
import 'package:serv_facil/widgets/text_input.dart';

class ModalAddOs extends StatefulWidget {
  const ModalAddOs({super.key});

  @override
  State<ModalAddOs> createState() => _ModalAddOsState();
}

class _ModalAddOsState extends State<ModalAddOs> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();

  void _addOs() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    OsService.addOs(colaborador: user, descricao: _descriptionController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 25),
                const Text(
                  'Nova ordem de serviço',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextInput(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um comentário para cirar uma OS.';
                    }
                    return null;
                  },
                  hintText: 'Descrição',
                  margin: const EdgeInsets.symmetric(vertical: 25),
                ),
                Button(
                  onTap: _addOs,
                  text: 'Criar',
                  margin: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
