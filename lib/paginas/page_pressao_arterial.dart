import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidney_app/utils/utils.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kidney_app/model/pressao_arterial.dart';
import 'package:kidney_app/database/pressao_arterial_data.dart';


class PagePressaoArterial extends StatefulWidget {
  final PressaoArterial pressaoArterial;
  PagePressaoArterial({this.pressaoArterial, Key key}) : super(key: key);

  @override
  _PagePressaoArterial createState() => _PagePressaoArterial(pressaoArterial: this.pressaoArterial);
}


class _PagePressaoArterial extends State<PagePressaoArterial> {
  final PressaoArterial pressaoArterial;

  _PagePressaoArterial({this.pressaoArterial, Key key});

  final _formKey = GlobalKey<FormState>();
  final horaController = TextEditingController();
  final dataController = TextEditingController();
  final diastolicaController = MaskedTextController(mask: '000');
  final sistolicaController = MaskedTextController(mask: '000');

  DateTime _dataInfo = DateTime.now();
  TimeOfDay _horaInfo = TimeOfDay.now();


  @override
  void initState() {
    super.initState();
    if (pressaoArterial != null && pressaoArterial.id != null) {
      _dataInfo = pressaoArterial.dataHora;
      _horaInfo = TimeOfDay.fromDateTime(pressaoArterial.dataHora);
      sistolicaController.text = pressaoArterial.sistolica.toString();
      diastolicaController.text = pressaoArterial.diastolica.toString();

    }
  }

  Widget build(BuildContext context) {
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    width: 120,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: sistolicaController,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          labelText: 'Sistólica',
                                          suffixText: 'mmhg',
                                          suffixStyle: TextStyle(
                                            fontSize: 10
                                          )
                                      ),
                                      validator: (sistolica) {
                                        if (sistolica.isEmpty) {
                                          return 'Preencha a pressão sistólica';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Text('/'),
                                  SizedBox(
                                    width: 120,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: diastolicaController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          labelText: 'Diastólica',
                                        suffixText: 'mmhg'
                                      ),
                                      validator: (diastolica) {
                                        if (diastolica.isEmpty) {
                                          return 'Preencha a pressão diastólica';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: RaisedButton(
                          child: Text(pressaoArterial != null ? 'Salvar' : 'Incluir'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              PressaoArterialDatabase.insert(PressaoArterial(
                                dataHora: Utils.dataHora(_dataInfo, _horaInfo),
                                diastolica: int.parse(diastolicaController.text),
                                sistolica: int.parse(sistolicaController.text),
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
