import 'package:flutter/material.dart';
import 'package:serv_facil/main.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/screens/details.dart';
import 'package:serv_facil/widgets/UI/form_widgets/button.dart';
import 'package:serv_facil/widgets/UI/info_row.dart';

class OpenOsWidget extends StatelessWidget {
  const OpenOsWidget({
    super.key,
    required this.os,
  });

  final Os os;

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  InfoRow(
                    label: 'Executor',
                    info: os.executor == null
                        ? 'Não possui'
                        : '${os.executor!.nome.split(' ')[0]} ${os.executor!.nome.split(' ')[1]}',
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  InfoRow(
                    label: 'Início',
                    info:
                        '${_formatNumber(os.abertura.day)}/${_formatNumber(os.abertura.month)}/${os.abertura.year}',
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          onPressed: () {},
                          text: 'Atribuir a mim',
                          color: Theme.of(context).colorScheme.primary,
                          width: double.minPositive,
                        ),
                        const SizedBox(width: 10),
                        Button(
                          onPressed: () => navigatorKey.currentState?.push(
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(os: os),
                            ),
                          ),
                          text: 'Detalhes',
                          color: Theme.of(context).colorScheme.primary,
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
