import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidney_app/model/agenda.dart';
import 'package:kidney_app/database/agenda_data.dart';
import 'package:kidney_app/paginas/page_agenda.dart';
import 'package:kidney_app/utils/utils.dart';
import 'package:kidney_app/utils/constantes.dart';

class PageListaAgenda extends StatefulWidget {

  PageListaAgenda({Key key}) : super(key: key);

  @override
  _PageListaAgenda createState() => _PageListaAgenda();
}


class _PageListaAgenda extends State<PageListaAgenda> {
  _PageListaAgenda({Key key});

  Future<List<Agenda>> _agenda;

  @override
  void initState() {
    super.initState();
    _agenda = AgendaDatabase.lista();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        body:  Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              //Container(
                //  padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                  //child: Center()
              //),
              Container(
                  height: 540,
                  child: listaAgenda()
              ),
            ]
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageAgenda()),
                ).then((mensagem) {
                  if (mensagem != null) {
                    setState(() {
                      _agenda = AgendaDatabase.lista();
                    });
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(mensagem),
                    ));
                  }
                });
              },
              tooltip: 'Incluir evento',
              child: Icon(Icons.add),
            );
          },
        )
    );
  }


  Widget listaAgenda() {
    return Builder(
      builder: (BuildContext context) {
        return FutureBuilder(
          future: _agenda,
          builder: (context, agendaSnap) {
            if (agendaSnap.data != null && agendaSnap.data.length == 0)
              return Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  Constantes.SEM_CONSULTAS,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              );
            String data = '';
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
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
          },
        );
      },
    );

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
          width: 336,
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
