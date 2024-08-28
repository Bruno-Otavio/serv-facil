import 'package:flutter/material.dart';
import 'package:serv_facil/models/os.dart';
import 'package:serv_facil/widgets/button.dart';
import 'package:serv_facil/widgets/os/os_item_info.dart';

class OsItem extends StatelessWidget {
  const OsItem({
    super.key,
    required this.os,
  });

  final Os os;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: os.finished
            ? Theme.of(context).colorScheme.tertiary.withOpacity(0.55)
            : Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  os.descricao,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                ),
              ),
              OsItemInfo(title: 'Colaborador', content: os.colaborador),
              OsItemInfo(
                title: 'Data',
                content:
                    '${os.abertura.day}/${os.abertura.month}/${os.abertura.year}, ${os.abertura.hour}:${os.abertura.minute}',
              ),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      onTap: () {},
                      text: 'Detalhes',
                      margin: const EdgeInsets.only(left: 150, top: 5, bottom: 5),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
