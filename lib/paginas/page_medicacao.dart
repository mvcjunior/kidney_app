import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidney_app/database/medicacao_data.dart';
import 'package:kidney_app/model/medicacao.dart';
import 'package:kidney_app/utils/utils.dart';

class PageMedicacao extends StatefulWidget {
  final Medicacao medicacao;

  PageMedicacao({this.medicacao, Key key}) : super(key: key);

  @override
  _PageMedicacao createState() => _PageMedicacao(medicacao: this.medicacao);
}


class _PageMedicacao extends State<PageMedicacao> {
  final Medicacao medicacao;

  _PageMedicacao({this.medicacao, Key key});

  final _formKey = GlobalKey<FormState>();
  final horaController = TextEditingController();
  final nomeController = TextEditingController();
  final quantidadeController = TextEditingController();

  TimeOfDay _horaInfo = TimeOfDay.now();



  @override
  void initState() {
    super.initState();
    if (medicacao != null && medicacao.id != null) {
      _horaInfo = medicacao.hora;
      nomeController.text = medicacao.nome;
      quantidadeController.text = medicacao.quantidade.toString();

    }

  }

  Widget build(BuildContext context2) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20 , 0, 0),
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(40, 30 , 40, 0),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          MaterialButton(
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.access_time, size: 28),
                                Text(' ${Utils.formataHora(_horaInfo)}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              TimeOfDay hrPick = await showTimePicker(
                                context: context,
                                initialTime: _horaInfo,
                              );
                              if (hrPick != null && hrPick != _horaInfo) {
                                setState(() {
                                  _horaInfo = hrPick;
                                });
                              }
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            controller: nomeController,
                            decoration: InputDecoration(
                              labelText: 'Nome Medicação',
                            ),
                            validator: (nome) {
                              if (nome.isEmpty) {
                                return 'Preencha o nome da medicação';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: quantidadeController,
                            decoration: InputDecoration(
                              labelText: 'Quantidade',
                            ),
                            validator: (quantidade) {
                              if (quantidade.isEmpty) {
                                return 'Preencha a quantidade';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: RaisedButton(
                        child: Text(medicacao != null ? 'Salvar' : 'Incluir'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (this.medicacao == null || this.medicacao.id == null)
                              MedicacaoDatabase.insert(Medicacao(
                                hora: _horaInfo,
                                nome: nomeController.text,
                                quantidade: int.parse(quantidadeController.text),
                              ));
                            else
                              MedicacaoDatabase.altera(Medicacao(
                                id: this.medicacao.id,
                                hora: _horaInfo,
                                nome: nomeController.text,
                                quantidade: int.parse(quantidadeController.text),
                              ));
                            Navigator.pop(context);
                          }
                        },
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}
