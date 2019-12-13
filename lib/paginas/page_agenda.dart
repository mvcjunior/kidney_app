import 'package:flutter/material.dart';
import 'package:kidney_app/database/agenda_data.dart';
import 'package:kidney_app/model/agenda.dart';
import 'package:kidney_app/model/agenda.dart';
import 'package:kidney_app/utils/utils.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PageAgenda extends StatefulWidget {
  final Agenda agenda;

  PageAgenda({this.agenda, Key key}) : super(key: key);

  @override
  _PageAgenda createState() => _PageAgenda(agenda: this.agenda);
}


class _PageAgenda extends State<PageAgenda> {
  final Agenda agenda;

  _PageAgenda({this.agenda, Key key});

  final _formKey = GlobalKey<FormState>();
  final dataController = TextEditingController();
  final horaController = TextEditingController();
  final localController = TextEditingController();
  final eventoController = TextEditingController();
  final tipoEventoController = TextEditingController();

  DateTime _dataInfo = DateTime.now();
  TimeOfDay _horaInfo = TimeOfDay.now();



  @override
  void initState() {
    super.initState();
    if (agenda != null) {
      _dataInfo = agenda.dataHora;
      _horaInfo = TimeOfDay.fromDateTime(agenda.dataHora);
      localController.text = agenda.local;
      eventoController.text = agenda.evento;
      tipoEventoController.text = agenda.tipoEvento;

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
                            keyboardType: TextInputType.text,
                            controller: localController,
                            decoration: InputDecoration(
                              labelText: 'Local',
                            ),
                            validator: (local) {
                              if (local.isEmpty) {
                                return 'Preencha o local';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: eventoController,
                            decoration: InputDecoration(
                              labelText: 'Evento',
                            ),
                            validator: (evento) {
                              if (evento.isEmpty) {
                                return 'Preencha o evento';
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
                        child: Text(agenda != null ? 'Salvar' : 'Incluir'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            AgendaDatabase.insert(Agenda(
                              dataHora: Utils.dataHora(_dataInfo, _horaInfo),
                              local: localController.text,
                              evento: eventoController.text,
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
