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
                        padding: EdgeInsets.fromLTRB(60, 30 , 60, 30),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 160,
                                  child: MaterialButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(Icons.calendar_today, size: 26),
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

                                ),
                                SizedBox(
                                  width: 108,
                                  child: MaterialButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Icon(Icons.access_time, size: 26),
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
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: sistolicaController,
                                      cursorColor: Colors.green[500],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        decorationColor: Colors.green[500],
                                      ),
                                      decoration: InputDecoration(
                                        focusColor: Colors.green[500],
                                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        hoverColor: Colors.green[500],
                                        suffixText: 'mmhg',
                                        suffixStyle: TextStyle(
                                          fontSize: 10,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.green[500],
                                        ),
                                        labelText: 'Sistólica',
                                        labelStyle: TextStyle(
                                            color: Colors.green[500],
                                            fontSize: 18
                                        ),
                                      ),
                                      validator: (sistolica) {
                                        if (sistolica.isEmpty) {
                                          return 'Preencha a pressão sistólica';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Text(
                                      '/',
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: diastolicaController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        suffixText: 'mmhg',
                                        suffixStyle: TextStyle(
                                          fontSize: 10,
                                        ),
                                        labelText: 'Diastólica',
                                        labelStyle: TextStyle(
                                            fontSize: 15
                                        ),
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
                        padding: EdgeInsets.fromLTRB(60, 20, 60, 0),
                        child: Row(
                          mainAxisAlignment: pressaoArterial != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
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
                            pressaoArterial != null ?
                            RaisedButton(
                              child: Text('Excluir'),
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
                            ) :
                                Center()
                          ],
                        )
                      )
                    ],
                )
            )
        )
    );
  }
}
