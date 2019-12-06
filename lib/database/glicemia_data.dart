import 'dart:async';
import 'package:kidney_app/model/glicemia.dart';
import 'package:kidney_app/model/pressao_arterial.dart';

import 'database.dart';
import 'package:sqflite/sqflite.dart';

class GlicemiaDatabase {
  static final database = createDatabase();
  static final List<Glicemia> base = List();

  static Future<void> insert(Glicemia glicemia) async {
    base.add(Glicemia(id: base.length+1,
        indiceGlicemico: glicemia.indiceGlicemico,
        dataHora: glicemia.dataHora,
        dataHoraAlteracao: DateTime.now(),
        dataHoraInclusao: DateTime.now()));

 /*   final Database db = await database;

    await db.insert(
      'glicemia',
      glicemia.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); */
  }

  static Future<List<Glicemia>> lista() async {
    //final Database db = await database;
    //final List<Map<String, dynamic>> maps = await db.query('glicemia', orderBy: 'data_hora');
    // query(String table, {bool distinct, List<String> columns, String where, List<dynamic> whereArgs, String groupBy, String having, String orderBy, int limit, int offset}
    print(base);
    print(base.length);

    return List.generate(base.length, (i) {
      return base[i];
    });

    /*return List.generate(base.length, (i) {
      print(maps[i]);
      return Glicemia(
        id: maps[i]['id'],
        dataHora: maps[i]['data_hora'],
        indiceGlicemico: maps[i]['indice_glicemico'],
        dataHoraInclusao: maps[i]['data_hora_inclusao'],
        dataHoraAlteracao: maps[i]['data_hora_alteracao']
      );
    });*/
  }

  Future<void> altera(Glicemia glicemia) async {

    base[glicemia.id] = glicemia;
    final db = await database;

    await db.update(
      'glicemia',
      glicemia.toMap(),
      where: "id = ?",
      whereArgs: [glicemia.id],
    );
  }


  Future<void> exclui(int id) async {
    final db = await database;

    await db.delete(
      'glicemia',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> excluiTodos() async {
    final db = await database;

    await db.delete('glicemia');
  }
}