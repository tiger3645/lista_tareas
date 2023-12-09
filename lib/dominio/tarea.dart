class TablaTareas {
  static const String nombreTabla = 'tareas';
  static const String id = '_id';
  static const String fechaHoraCreacion = 'fechaHoraCreacion';
  static const String descripcion = 'descripcion';
  static const String finalizada = 'finalizada';

  static const List<String> columnas = [
    id,
    fechaHoraCreacion,
    descripcion,
    finalizada
  ];
}

class Tarea {
  int? id; // opcional porque es autogenerado
  DateTime fechaHoraCreacion;
  String descripcion;
  bool finalizada;

  Tarea(
      {this.id,
      required this.fechaHoraCreacion,
      required this.descripcion,
      required this.finalizada});

  factory Tarea.fromMap(Map<String, Object?> mapa) {
    return Tarea(
      id: mapa[TablaTareas.id] as int?,
      fechaHoraCreacion:
          DateTime.parse(mapa[TablaTareas.fechaHoraCreacion] as String),
      descripcion: mapa[TablaTareas.descripcion] as String,
      finalizada: mapa[TablaTareas.finalizada] as int == 1,
    );
  }

  Map<String, Object?> toMap() {
    return {
      TablaTareas.id: id,
      TablaTareas.fechaHoraCreacion: fechaHoraCreacion.toIso8601String(),
      TablaTareas.descripcion: descripcion,
      TablaTareas.finalizada: finalizada ? 1 : 0,
    };
  }
}
