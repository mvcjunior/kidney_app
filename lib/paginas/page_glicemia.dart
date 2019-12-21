import 'package:flutter/material.dart';
import 'package:kidney_app/database/glicemia_data.dart';
import 'package:kidney_app/model/glicemia.dart';
import 'package:kidney_app/utils/utils.dart';

class PageGlicemia extends StatefulWidget {
  final Glicemia glicemia;

  PageGlicemia({this.glicemia, Key key}) : super(key: key);

  @override
  _PageGlicemia createState() => _PageGlicemia(glicemia: this.glicemia);
}


class _PageGlicemia extends State<PageGlicemia> {
  final Glicemia glicemia;

  _PageGlicemia({this.glicemia, Key key});

  final _formKey = GlobalKey<FormState>();
  final horaController = TextEditingController();
  final dataController = TextEditingController();
  final glicemiaController = TextEditingController();

  DateTime _dataInfo = DateTime.now();
  TimeOfDay _horaInfo = TimeOfDay.now();



  @override
  void initState() {
    super.initState();
    if (glicemia != null && glicemia.id != null) {
      _dataInfo = glicemia.dataHora;
      _horaInfo = TimeOfDay.fromDateTime(glicemia.dataHora);
      glicemiaController.text = glicemia.indiceGlicemico.toString();

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
                                Icon(Icons.calendar_today, size: 28),
                                Text(' ${Utils.formataData(_dataInfo)}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              final dtPick = await showDatePicker(
                                  context: context,
                                  initialDate: _dataInfo,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2100)
                              );
                              if (dtPick != null && dtPick != _dataInfo) {
                                setState(() {
                                  _dataInfo = dtPick;
                                });
                              }
                            },
                          ),
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
                            keyboardType: TextInputType.number,
                            controller: glicemiaController,
                            decoration: InputDecoration(
                              labelText: 'Glicemia',
                            ),
                            validator: (glicemia) {
                              if (glicemia.isEmpty) {
                                return 'Preencha a glicemia';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(60, 20, 60, 0),
                        child: Row(
                          mainAxisAlignment: glicemia != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              child: Text(glicemia != null ? 'Salvar' : 'Incluir'),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  GlicemiaDatabase.insert(Glicemia(
                                    dataHora: Utils.dataHora(_dataInfo, _horaInfo),
                                    indiceGlicemico: int.parse(glicemiaController.text),
                                  ));
                                  Navigator.pop(context, true);
                                }
                              },
                            ),
                            glicemia != null ?
                            RaisedButton(
                              child: Text('Excluir'),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    GlicemiaDatabase.insert(Glicemia(
                                      dataHora: Utils.dataHora(_dataInfo, _horaInfo),
                                      indiceGlicemico: int.parse(glicemiaController.text),
                                    ));
                                    Navigator.pop(context, true);
                                  }
                                },
                              ) :
                            Center()
                        ]
                    )
                )
              ]
            )
        ))
    );
  }
}
