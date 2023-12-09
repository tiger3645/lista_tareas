import 'package:flutter/material.dart';
import 'package:lista_tareas/paginas/pagina_inicio.dart';

void main() {
  runApp(const Aplicacion());
}

class Aplicacion extends StatelessWidget {
  const Aplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Lista de Tareas",
        home: PaginaInicio());
  }
}
