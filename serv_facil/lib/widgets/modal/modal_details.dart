import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/models/comment.dart';
import 'package:serv_facil/models/os.dart';
import 'package:serv_facil/models/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/comment_service.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/modal/info_container_widget.dart';
import 'package:serv_facil/widgets/UI/small_button.dart';
import 'package:serv_facil/widgets/UI/text_input.dart';

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

  User? user;

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
    user = Provider.of<UserProvider>(context).user;
    return !widget.os.finished
        ? _buildUnfishedOsModal(context)
        : _buildFinishedOsModal(context);
  }

  SizedBox _buildFinishedOsModal(BuildContext context) {
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
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5),
                  ),
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
              InfoContainerWidget(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Descrição:',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      widget.os.descricao,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: CommentService.getComments(
                    osId: widget.os.id,
                    token: user!.token!,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const InfoContainerWidget(
                        margin: EdgeInsets.only(top: 25),
                        child: Center(
                          child: LinearProgressIndicator(),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final data = snapshot.data!;
                      return InfoContainerWidget(
                        margin: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              'Comentários:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final Comment comment = data[index];
                                  return Text(comment.comentario);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          'Esta OS não possui comentários.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildUnfishedOsModal(BuildContext context) {
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
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(5),
                  ),
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
              Expanded(
                child: FutureBuilder(
                  future: CommentService.getComments(
                    osId: widget.os.id,
                    token: user!.token!,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const InfoContainerWidget(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final data = snapshot.data!;
                      return InfoContainerWidget(
                        margin: const EdgeInsets.symmetric(vertical: 7),
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final Comment comment = data[index];
                            return Text(comment.comentario);
                          },
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          'Esta OS não possui comentários ainda.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SmallButton(onTap: _updateOs, text: 'Alterar'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SmallButton(onTap: _removeOs, text: 'Excluir'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
