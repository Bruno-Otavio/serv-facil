import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/models/os.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/small_button.dart';
import 'package:serv_facil/widgets/text_input.dart';

class ModalDetails extends StatefulWidget {
  const ModalDetails({
    super.key,
    required this.os,
  });

  final Os os;

  @override
  State<ModalDetails> createState() => _ModalDetailsState();
}

class _ModalDetailsState extends State<ModalDetails> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  bool _commentSucess = false;

  void _updateOs() async {
    await OsService.updateOsDescription(
      id: widget.os.id,
      descricao: _controller.text,
      token: Provider.of<UserProvider>(context, listen: false).user.token!,
    );
  }

  void _removeOs() async {}

  @override
  void initState() {
    super.initState();
    _controller.text = widget.os.descricao;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.25),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ordem de Serviço',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    widget.os.id.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              TextInput(
                controller: _controller,
                validator: (value) => null,
                hintText: 'Descrição',
              ),
              Form(
                child: Row(
                  children: [
                    Expanded(
                      child: TextInput(
                        controller: _commentController,
                        validator: (value) {
                          return null;
                        },
                        hintText: 'Adicione um Comentário',
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_commentController.text != '') {
                          setState(() {
                            _commentSucess = !_commentSucess;
                          });
                          Future.delayed(const Duration(seconds: 3), () {
                            if (mounted) {
                              setState(() {
                                _commentSucess = !_commentSucess;
                              });
                            }
                          });
                        }
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
              _commentSucess
                  ? Text(
                      'Comentário adicionado com sucesso!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    )
                  : const Text(''),
              const Expanded(child: SizedBox.expand()),
              Row(
                children: [
                  Expanded(child: SmallButton(onTap: _updateOs, text: 'Alterar')),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: SmallButton(onTap: _removeOs, text: 'Excluir')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
