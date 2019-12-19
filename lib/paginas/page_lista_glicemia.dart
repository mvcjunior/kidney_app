import 'package:flutter/material.dart';
import 'package:kidney_app/database/glicemia_data.dart';
import 'package:kidney_app/model/glicemia.dart';
import 'package:kidney_app/model/pressao_arterial.dart';
import 'package:kidney_app/database/pressao_arterial_data.dart';
import 'package:kidney_app/paginas/page_glicemia.dart';
import 'package:kidney_app/paginas/page_pressao_arterial.dart';
import 'package:kidney_app/utils/utils.dart';

class PageListaGlicemia extends StatefulWidget {

  PageListaGlicemia({Key key}) : super(key: key);

  @override
  _PageListaGlicemia createState() => _PageListaGlicemia();
}


class _PageListaGlicemia extends State<PageListaGlicemia> {
  _PageListaGlicemia({Key key});

  Future<List<Glicemia>> _glicemia;

  @override
  void initState() {
    super.initState();
    _glicemia = GlicemiaDatabase.lista();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        body:  Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 30, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Data / Hora',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text('Medição',
                          style: TextStyle(fontSize: 20),)
                      ],
                    )
                  ),
                  Container(
                    height: 540,
                    child: listaGlicemia()
                  ),
                ]
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageGlicemia()),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
    );
  }

  Widget listaGlicemia() {
    return FutureBuilder(
      future: _glicemia,
      builder: (context, glicemiaSnap) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: glicemiaSnap.data != null ? glicemiaSnap.data.length : 0,
          itemBuilder: (context, index) {

            final List<Glicemia> item = glicemiaSnap.data;
            final Glicemia linha = item[index];
            return ListTile(
              title: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(Utils.formataDataHora(linha.dataHora)),
                      Text(Utils.formataGlicemia(linha.indiceGlicemico)),
                    ],
                  ),
                  Divider()
                ],
              ),
              onTap: () {
                print(item[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageGlicemia(glicemia: item[index],))
                ).then((alterado) {
                  setState(() {
                    _glicemia = GlicemiaDatabase.lista();
                  });
                });;
              },
            );
          },
        );
      },
    );
  }

}
