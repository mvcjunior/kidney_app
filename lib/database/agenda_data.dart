import 'dart:async';
import 'package:kidney_app/model/agenda.dart';
import 'package:kidney_app/model/pressao_arterial.dart';

import 'database.dart';
import 'package:sqflite/sqflite.dart';

class AgendaDatabase {
  static final database = createDatabase();
  static final List<Agenda> base = List();

  static Future<void> insert(Agenda agenda) async {
    base.add(Agenda(id: base.length+1,
        local: agenda.local,
        evento: agenda.evento,
        tipoEvento: agenda.tipoEvento,
        dataHora: agenda.dataHora,
        dataHoraAlteracao: DateTime.now(),
        dataHoraInclusao: DateTime.now()));

 /*   final Database db = await database;

    await db.insert(
      'agenda',
      agenda.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); */
  }

  static Future<List<Agenda>> lista() async {
    final Database db = await database;
    //final List<Map<String, dynamic>> maps = await db.query('agenda', orderBy: 'data_hora');
    // query(String table, {bool distinct, List<String> columns, String where, List<dynamic> whereArgs, String groupBy, String having, String orderBy, int limit, int offset}
    return List.generate(base.length, (i) {
      return base[i];
    });

   /* return List.generate(base.length, (i) {
      print(maps[i]);
      return Agenda(
        id: maps[i]['id'],
        dataHora: maps[i]['data_hora'],
        local: maps[i]['local'],
        evento: maps[i]['evento'],
        tipoEvento: maps[i]['id_tipo_evento'],
        dataHoraInclusao: maps[i]['data_hora_inclusao'],
        dataHoraAlteracao: maps[i]['data_hora_alteracao']
      );
    });*/
  }

  static Future<void> altera(Agenda agenda) async {

    base[agenda.id] = agenda;
    final db = await database;

    await db.update(
      'agenda',
      agenda.toMap(),
      where: "id = ?",
      whereArgs: [agenda.id],
    );
  }


  static Future<void> exclui(int id) async {
    final db = await database;

    await db.delete(
      'agenda',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> excluiTodos() async {
    // Get a reference to the database.
    final db = await database;

    await db.delete('agenda');
  }
}