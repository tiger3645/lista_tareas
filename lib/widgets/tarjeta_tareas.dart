import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_tareas/dominio/tarea.dart';

class TarjetaTarea extends StatelessWidget {
  final Tarea tarea;

  const TarjetaTarea({super.key, required this.tarea});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => mostrarDetalleTarea(context, tarea),
      child: Card(
          color: Colors.amber.shade100,
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
            title: Text(tarea.descripcion),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      //
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
          )),
    );
  }

  void mostrarDetalleTarea(BuildContext context, Tarea tarea) {
    showBottomSheet(
        context: context,
        builder: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Detalle de Tarea',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 50),
                    Text('Id: ${tarea.id}'),
                    const SizedBox(height: 10),
                    Text(
                        'Creación: ${DateFormat('dd/MM/yyyy HH:mm').format(tarea.fechaHoraCreacion)}'),
                    const SizedBox(height: 10),
                    Text('Descripción: ${tarea.descripcion}'),
                    const SizedBox(height: 10),
                    Text('Finalizada: ${tarea.finalizada ? 'Si' : 'No'}'),
                  ],
                ),
              ),
            ));
  }
}
