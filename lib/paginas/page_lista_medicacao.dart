import 'package:flutter/material.dart';
import 'package:kidney_app/database/medicacao_data.dart';
import 'package:kidney_app/model/glicemia.dart';
import 'package:kidney_app/model/medicacao.dart';
import 'package:kidney_app/model/pressao_arterial.dart';
import 'package:kidney_app/database/pressao_arterial_data.dart';
import 'package:kidney_app/paginas/page_glicemia.dart';
import 'package:kidney_app/paginas/page_medicacao.dart';
import 'package:kidney_app/utils/utils.dart';
import 'package:kidney_app/utils/notificacao.dart';

class PageListaMedicacao extends StatefulWidget {

  PageListaMedicacao({Key key}) : super(key: key);

  @override
  _PageListaMedicacao createState() => _PageListaMedicacao();
}


class _PageListaMedicacao extends State<PageListaMedicacao> {
  _PageListaMedicacao({Key key});

  Future<List<Medicacao>> _medicacao;

  @override
  void initState() {
    super.initState();
    _medicacao = MedicacaoDatabase.lista();
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
                        Text('Hora',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text('Medicação',
                          style: TextStyle(fontSize: 15),),
                        Text('Quantidade',
                          style: TextStyle(fontSize: 15),)
                      ],
                    )
                  ),
                  Container(
                    height: 540,
                    child: listaMedicacao()
                  ),
                ]
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            NotificacaoDiaria().lista();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageMedicacao()),
            ).then((alterado){
              if (alterado != null && alterado) {
                _medicacao = MedicacaoDatabase.lista();
                setState(() {
                });
              }
            });
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
    );
  }

  Widget listaMedicacao() {
    return FutureBuilder(
      future: _medicacao,
      builder: (context, medicacaoSnap) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: medicacaoSnap.data != null ? medicacaoSnap.data.length : 0,
          itemBuilder: (context, index) {

            final List<Medicacao> item = medicacaoSnap.data;
            final Medicacao linha = item[index];
            return ListTile(
              title: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(Utils.formataHora(linha.hora)),
                      Text(linha.nome),
                      Text(linha.quantidade.toString()),
                    ],
                  ),
                  Divider()
                ],
              ),
              onTap: () {
                print(item[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageMedicacao(medicacao: item[index],))
                ).then((alterado){
                  if (alterado != null && alterado) {
                    _medicacao = MedicacaoDatabase.lista();
                    setState(() {
                    });
                  }
                });
              },
            );
          },
        );
      },
    );
  }

}
