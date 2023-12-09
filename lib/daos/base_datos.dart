import 'package:lista_tareas/dominio/tarea.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseDatos {
  static final BaseDatos _instancia = BaseDatos._inicializar();

  Database? _baseDatos;

  BaseDatos._inicializar();

  factory BaseDatos() {
    return _instancia;
  }

  Future<Database> obtenerBaseDatos() async {
    // la exclamación es afirmando de que _baseDatos va a estar inicializada bien
    if (_baseDatos != null) return _baseDatos!;

    final String rutaDirectorioBasesDatos = await getDatabasesPath();
    final String rutaBD = join(rutaDirectorioBasesDatos, "lista_tareas.sqlite");

    _baseDatos =
        await openDatabase(rutaBD, version: 1, onCreate: (db, version) {
      db.execute('''
          CREATE TABLE ${TablaTareas.nombreTabla} (
            ${TablaTareas.id} INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            ${TablaTareas.fechaHoraCreacion} TEXT NOT NULL,
            ${TablaTareas.descripcion} TEXT NOT NULL,
            ${TablaTareas.finalizada} INTEGER NOT NULL
          );
        ''');

      db.execute("""
        INSERT INTO ${TablaTareas.nombreTabla}
        VALUES (NULL, '${DateTime.now()}', 'Estudiar teórico de sqflite.', 1);
      """);

      db.execute("""
        INSERT INTO ${TablaTareas.nombreTabla}
        VALUES (NULL, '${DateTime.now()}', 'Copiar ejemplo de sqflite.', 0);
      """);

      db.execute("""
        INSERT INTO ${TablaTareas.nombreTabla}
        VALUES (NULL, '${DateTime.now()}', 'Repasar teórico de sqflite.', 0);
      """);
    });

    return _baseDatos!;
  }

  Future<void> cerrarBaseDatos() async {
    await _baseDatos?.close();

    _baseDatos = null;
  }
}
