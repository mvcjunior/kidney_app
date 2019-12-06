import 'dart:async';
import 'package:kidney_app/model/pressao_arterial.dart';

import 'database.dart';
import 'package:sqflite/sqflite.dart';

class PressaoArterialDatabase {
  static final database = createDatabase();
  static final List<PressaoArterial> base = List();

  static Future<void> insert(PressaoArterial pressaoArterial) async {
    base.add(PressaoArterial(id: base.length+1,
        sistolica: pressaoArterial.sistolica,
        diastolica: pressaoArterial.diastolica,
        dataHora: pressaoArterial.dataHora,
        dataHoraAlteracao: DateTime.now(),
        dataHoraInclusao: DateTime.now()));

 /*   final Database db = await database;

    await db.insert(
      'pressao_arterial',
      pressaoArterial.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); */
  }

  static Future<List<PressaoArterial>> lista() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pressao_arterial', orderBy: 'data_hora');
    // query(String table, {bool distinct, List<String> columns, String where, List<dynamic> whereArgs, String groupBy, String having, String orderBy, int limit, int offset}
    print(base);
    print(base.length);

    return List.generate(base.length, (i) {
      return base[i];
    });

    return List.generate(base.length, (i) {
      print(maps[i]);
      return PressaoArterial(
        id: maps[i]['id'],
        dataHora: maps[i]['data_hora'],
        sistolica: maps[i]['sistolica'],
        diastolica: maps[i]['diastolica'],
        dataHoraInclusao: maps[i]['data_hora_inclusao'],
        dataHoraAlteracao: maps[i]['data_hora_alteracao']
      );
    });
  }

  Future<void> altera(PressaoArterial pressaoArterial) async {

    base[pressaoArterial.id] = pressaoArterial;
    final db = await database;

    await db.update(
      'pressao_arterial',
      pressaoArterial.toMap(),
      where: "id = ?",
      whereArgs: [pressaoArterial.id],
    );
  }


  Future<void> exclui(int id) async {
    final db = await database;

    await db.delete(
      'pressao_arterial',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> excluiTodos() async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete('pressao_arterial');
  }
}