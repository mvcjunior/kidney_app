import 'dart:async';
import 'package:kidney_app/model/medicacao.dart';
import 'package:kidney_app/utils/notificacao.dart';

import 'database.dart';
import 'package:sqflite/sqflite.dart';

class MedicacaoDatabase {
  static final database = createDatabase();
  static final List<Medicacao> base = List();

  static Future<void> insert(Medicacao medicacao) async {
    Medicacao medicacaoNew = Medicacao(id: base.length+1,
        nome: medicacao.nome,
        quantidade: medicacao.quantidade,
        hora: medicacao.hora,
        dataHoraAlteracao: DateTime.now(),
        dataHoraInclusao: DateTime.now());

    base.add(medicacaoNew);
    NotificacaoDiaria().iniciar(medicacaoNew);
 /*   final Database db = await database;

    await db.insert(
      'medicacao',
      medicacao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); */
  }

  static Future<List<Medicacao>> lista() async {
    //final Database db = await database;
    //final List<Map<String, dynamic>> maps = await db.query('medicacao', orderBy: 'hora');
    // query(String table, {bool distinct, List<String> columns, String where, List<dynamic> whereArgs, String groupBy, String having, String orderBy, int limit, int offset}
    print(base);
    print(base.length);

    return List.generate(base.length, (i) {
      return base[i];
    });

    /*return List.generate(base.length, (i) {
      print(maps[i]);
      return Medicacao(
        id: maps[i]['id'],
        hora: maps[i]['hora'],
        nome: maps[i]['nome'],
        quantidade: maps[i]['quantidade'],
        unidade: maps[i]['unidade'],
        dataHoraInclusao: maps[i]['data_hora_inclusao'],
        dataHoraAlteracao: maps[i]['data_hora_alteracao']
      );
    });*/
  }

  static Future<void> altera(Medicacao medicacao) async {

    base[medicacao.id-1] = medicacao;
    final db = await database;

    await db.update(
      'medicacao',
      medicacao.toMap(),
      where: "id = ?",
      whereArgs: [medicacao.id],
    );
  }


  Future<void> exclui(int id) async {
    final db = await database;

    await db.delete(
      'medicacao',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> excluiTodos() async {
    final db = await database;

    await db.delete('medicacao');
  }
}