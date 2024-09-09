import 'package:flutter/material.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/widgets/UI/button.dart';
import 'package:serv_facil/widgets/info_row.dart';

class TakenOsWidget extends StatelessWidget {
  const TakenOsWidget({
    super.key,
    required this.os,
  });

  final Os os;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(3),
                  topLeft: Radius.circular(3),
                ),
              ),
              child: Text(
                os.descricao,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onTertiary,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  InfoRow(
                    label: 'Colaborador',
                    info:
                        '${os.colaborador.nome.split(' ')[0]} ${os.colaborador.nome.split(' ')[1]}',
                  ),
                  const InfoRow(label: 'Executor', info: ''),
                  InfoRow(
                      label: 'Início',
                      info:
                          '${os.abertura.day}/${os.abertura.month}/${os.abertura.year}'),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          onPressed: () {},
                          text: 'Encerrar',
                          color: Theme.of(context).colorScheme.tertiary,
                          width: double.minPositive,
                        ),
                        const SizedBox(width: 10),
                        Button(
                          onPressed: () {},
                          text: 'Detalhes',
                          color: Theme.of(context).colorScheme.tertiary,
                          width: double.minPositive,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
