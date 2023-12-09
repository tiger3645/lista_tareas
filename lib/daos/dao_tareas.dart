import 'package:lista_tareas/daos/base_datos.dart';
import 'package:lista_tareas/dominio/tarea.dart';
import 'package:sqflite/sqflite.dart';

class DAOTareas {
  static final DAOTareas _instancia = DAOTareas._inicializar();

  DAOTareas._inicializar();

  factory DAOTareas() {
    return _instancia;
  }

  Future<List<Tarea>> listarTareas() async {
    Database bd = await BaseDatos().obtenerBaseDatos();

    List<Map<String, Object?>> listaTareas =
        await bd.query(TablaTareas.nombreTabla);

    return listaTareas.map((e) => Tarea.fromMap(e)).toList();
  }

  Future<List<Tarea>> listarTareasXEstado(bool finalizadas) async {
    Database bd = await BaseDatos().obtenerBaseDatos();

    List<Map<String, Object?>> listaTareas = await bd.query(
        TablaTareas.nombreTabla,
        where: '${TablaTareas.finalizada} = ?',
        whereArgs: [finalizadas ? 1 : 0]);

    return listaTareas.map((e) => Tarea.fromMap(e)).toList();
  }

  Future<Tarea?> obtenerTarea(int id) async {
    Database bd = await BaseDatos().obtenerBaseDatos();

    List<Map<String, Object?>> listaTareas = await bd.query(
        TablaTareas.nombreTabla,
        where: '${TablaTareas.id} = ?',
        whereArgs: [id]);

    return listaTareas.isNotEmpty ? Tarea.fromMap(listaTareas.first) : null;
  }

  Future<int> agregarTarea(Tarea tarea) async {
    Database bd = await BaseDatos().obtenerBaseDatos();

    return await bd.insert(TablaTareas.nombreTabla, tarea.toMap());
  }

  Future<int> modificarTarea(Tarea tarea) async {
    Database bd = await BaseDatos().obtenerBaseDatos();

    return await bd.update(TablaTareas.nombreTabla, tarea.toMap(),
        where: '${TablaTareas.id} = ?', whereArgs: [tarea.id]);
  }

  Future<int> eliminarTarea(int id) async {
    Database bd = await BaseDatos().obtenerBaseDatos();

    return await bd.delete(TablaTareas.nombreTabla,
        where: '${TablaTareas.id} = ?', whereArgs: [id]);
  }
}
