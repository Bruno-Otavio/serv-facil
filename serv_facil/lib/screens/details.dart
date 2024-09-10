import 'package:flutter/material.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/widgets/UI/button.dart';
import 'package:serv_facil/widgets/info_row.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.os,
  });

  final Os os;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  String _formatDate(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;
    return '${_formatNumber(day)}/${_formatNumber(month)}/$year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('Descrição',),
            Text(widget.os.descricao),
            InfoRow(
              label: 'Executor',
              info: widget.os.executor != null
                  ? widget.os.executor!.nome
                  : 'Não possui',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            InfoRow(
              label: 'Início',
              info: _formatDate(widget.os.abertura),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            InfoRow(
              label: 'Encerramento',
              info: widget.os.encerramento != null
                  ? _formatDate(widget.os.encerramento!)
                  : 'Não finalizado',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Button(onPressed: () {}, text: 'Visualizar Comentários', color: Theme.of(context).colorScheme.tertiary),
          ],
        ),
      ),
    );
  }
}
