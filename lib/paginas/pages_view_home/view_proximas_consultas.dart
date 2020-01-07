import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidney_app/model/agenda.dart';
import 'package:kidney_app/database/agenda_data.dart';
import 'package:kidney_app/utils/constantes.dart';
import 'package:kidney_app/utils/utils.dart';
import 'package:kidney_app/paginas/page_agenda.dart';

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
          String data = '';
          return agendaSnap.data == null || agendaSnap.data.length == 0  ?
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  Constantes.SEM_CONSULTAS_PROXIMOS_30,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              )
              : ListView.builder(
                itemCount: agendaSnap.data != null ? agendaSnap.data.length : 0,
                itemBuilder: (context, index) {
                  final List<Agenda> item = agendaSnap.data;
                  final Agenda linha = item[index];
                  if (data != Utils.anoMesDia(linha.dataHora) ) {
                    data = Utils.anoMesDia(linha.dataHora);
                    return ListTile(
                      title: Column(
                        children: <Widget>[
                          Divider(),
                          _data(linha),
                          _evento(linha)
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageAgenda(agenda: item[index])),
                        ).then((mensagem) {
                          if (mensagem != null) {
                            setState(() {
                              _agenda = AgendaDatabase.lista();
                            });
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(mensagem),
                              ),
                            );
                          }
                        });
                      },
                    );
                  }
                  return ListTile(
                    title: Column(
                      children: <Widget>[
                        _evento(linha)
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageAgenda(agenda: item[index])),
                      ).then((mensagem) {
                        if (mensagem != null) {
                          setState(() {
                            _agenda = AgendaDatabase.lista();
                          });
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(mensagem),
                            ),
                          );
                        }
                      });
                    },
                  );
                },
            );
      });
    }

  Widget _data(Agenda agenda) {
    return Row(
      children: <Widget>[
        Text(
          Utils.formataDia(agenda.dataHora),
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),
        ),
        Text(' '),
        Text(
          Utils.formataMes(agenda.dataHora),
          textAlign: TextAlign.end,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }

  Widget _evento(Agenda agenda) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 8, 0),
          width: 43,
          height: 35,
          child: Text(
            Utils.formataHoraDateTime(agenda.dataHora),
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          width: 275,
          height: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  agenda.tipoEvento,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: Text(agenda.evento),
              ),
              Expanded(
                child: Text(agenda.local),
              ),
            ],
          ),
        ),
      ],
    );
  }
}