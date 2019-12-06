import 'package:flutter/material.dart';
import 'package:kidney_app/model/pressao_arterial.dart';
import 'package:kidney_app/database/pressao_arterial_data.dart';
import 'package:kidney_app/paginas/page_pressao_arterial.dart';
import 'package:kidney_app/utils/utils.dart';

class PageListaPressaoArterial extends StatefulWidget {

  PageListaPressaoArterial({Key key}) : super(key: key);

  @override
  _PageListaPressaoArterial createState() => _PageListaPressaoArterial();
}


class _PageListaPressaoArterial extends State<PageListaPressaoArterial> {
  _PageListaPressaoArterial({Key key});

  Future<List<PressaoArterial>> _pressaoArterial;

  @override
  void initState() {
    super.initState();
    _pressaoArterial = PressaoArterialDatabase.lista();
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
                    height: 600,
                    child: listaPressaoArterial()
                  ),
                ]
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PagePressaoArterial()),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
    );
  }

  Widget listaPressaoArterial() {
    return FutureBuilder(
      future: _pressaoArterial,
      builder: (context, pressaoArterialSnap) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: pressaoArterialSnap.data != null ? pressaoArterialSnap.data.length : 0,
          itemBuilder: (context, index) {

            final List<PressaoArterial> item = pressaoArterialSnap.data;
            final PressaoArterial linha = item[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(Utils.formataDataHora(linha.dataHora)),
                  Text(Utils.formataPressao(linha.sistolica, linha.diastolica)),
                ],
              ),
              onTap: () {
                print(item[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PagePressaoArterial(pressaoArterial: item[index],))
                );
              },
            );
          },
        );
      },
    );
  }

}
