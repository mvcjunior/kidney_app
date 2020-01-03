import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidney_app/model/agenda.dart';
import 'package:kidney_app/database/agenda_data.dart';

class ViewProximasConsultas extends StatefulWidget {
  ViewProximasConsultas({Key key}) : super(key: key);

  @override
  _ViewProximasConsultas createState() => _ViewProximasConsultas();
}

class _ViewProximasConsultas extends State<ViewProximasConsultas> {

  _ViewProximasConsultas({Key key});

  Future<List<Agenda>> _agenda;

  @override
  void initState() {
    _agenda = AgendaDatabase.lista().then((a){
      setState(() {

      });
    });
    super.initState();
  }



  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AgendaDatabase.lista(),
        builder: (context, agendaSnap) {
          return agendaSnap.data == null ?
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Não há consultas agendadas para os próximos 30 dias',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              )
              : ListView.builder(
                itemCount: agendaSnap.data != null ? agendaSnap.data.length : 0,
                itemBuilder: (context, index) {
                  final List<Agenda> item = agendaSnap.data;
                  return ListTile(
                          title: Container(
                            child: Text(item[index].evento),
                          )
                      );
                },
            );
      });
    }
}