import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidney_app/model/agenda.dart';
import 'package:kidney_app/database/agenda_data.dart';
import 'package:kidney_app/paginas/page_agenda.dart';
import 'package:kidney_app/utils/utils.dart';

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
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: Center()
                  ),
                  Container(
                    height: 540,
                    child: listaAgenda()
                  ),
                ]
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageAgenda()),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
    );
  }

  Widget listaAgenda() {
    return FutureBuilder(
      future: _agenda,
      builder: (context, agendaSnap) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: agendaSnap.data != null ? agendaSnap.data.length : 0,
          itemBuilder: (context, index) {

            final List<Agenda> item = agendaSnap.data;
            final Agenda linha = item[index];
            return ListTile(
              title: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(Utils.formataDataHora(linha.dataHora)),
                      Text(linha.tipoEvento),
                      Text(linha.evento),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                children: <Widget>[
                  Text(linha.local)
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageAgenda(agenda: item[index])),
                );
              },
            );
          },
        );
      },
    );
  }

}
