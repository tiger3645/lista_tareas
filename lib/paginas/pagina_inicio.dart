import 'package:flutter/material.dart';
import 'package:lista_tareas/daos/base_datos.dart';
import 'package:lista_tareas/daos/daos.dart';
import 'package:lista_tareas/widgets/tarjeta_tareas.dart';

class PaginaInicio extends StatefulWidget {
  const PaginaInicio({super.key});

  @override
  State<PaginaInicio> createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  int _indicePestaniaActial = 0;

  @override
  Widget build(BuildContext context) {
    BaseDatos().obtenerBaseDatos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: FutureBuilder(
        future: _indicePestaniaActial == 0
            ? DAOTareas().listarTareasXEstado(false)
            : DAOTareas().listarTareas(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) =>
                            TarjetaTarea(tarea: snapshot.data![index]),
                        itemCount: snapshot.data!.length,
                      )
                    : const Center(child: Text("No hay tareas para mostrar."));
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('¡ERROR! No se pudo listar las tareas.'),
                );
              } else {
                return const SizedBox.shrink();
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indicePestaniaActial,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.pending_actions), label: 'Pendientes'),
          BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: 'Todas'),
        ],
        onTap: (value) {
          setState(() {
            _indicePestaniaActial = value;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    BaseDatos().cerrarBaseDatos();

    super.dispose();
  }
}
