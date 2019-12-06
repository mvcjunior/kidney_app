
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


createDatabase() async {
  String databasesPath = await getDatabasesPath();
  String dbPath = join(databasesPath, 'kidney.app.db');
  var database = await openDatabase(dbPath, version: 1, onCreate: populateDb, onUpgrade: upgradeDb   );
  return database;
}

void populateDb(Database database, int version) async {
  await database.execute("CREATE TABLE pressao_arterial ("
      "id INTEGER PRIMARY KEY, sistolica INTEGER, diastolica INTEGER, "
      "data_hora TEXT, data_hora_inclusao TEXT, data_hora_alteracao TEXT)");

  await database.execute("CREATE TABLE glicemia ("
      "id INTEGER PRIMARY KEY, indice_glicemico INTEGER, "
      "data_hora TEXT, data_hora_inclusao TEXT, data_hora_alteracao TEXT)");
}

void upgradeDb(Database database, int atual, int nova) async {
  print ('upgradeDb');
  print (atual);
  print (nova);


}