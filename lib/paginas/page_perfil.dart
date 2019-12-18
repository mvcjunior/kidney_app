import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kidney_app/utils/constantes.dart';

class PagePerfil extends StatefulWidget {

  PagePerfil({Key key}) : super(key: key);

  @override
  _PagePerfil createState() => _PagePerfil();
}


class _PagePerfil extends State<PagePerfil> {

  _PagePerfil({Key key});

  String _nome = "";
  String _cpf = "";
  String _email = "";
  String _telefone = "";
  String _dataNascimento = "";
  bool _lights = false;

  @override
  void initState() {
    super.initState();
    _loadPerfil();
  }

  _loadPerfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      _nome = prefs.getString(Constantes.NOME) != null ?   prefs.getString(Constantes.NOME) : "";
      _cpf = prefs.getString(Constantes.CPF) != null ? prefs.getString(Constantes.CPF) : "";
      _email = (prefs.getString(Constantes.EMAIL) ?? "");
      _telefone = (prefs.getString(Constantes.TELEFONE) ?? "");
      _dataNascimento = (prefs.getString(Constantes.DATA_NASCIMENTO) ?? "");
      setState(() {

      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20 , 0, 0),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    print('cpf');
                  },
                  child: Container(
                    color: Colors.yellow,
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text(Constantes.CPF),
                        Text(_cpf)
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0 , 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Text(Constantes.NOME),
                      Text(_nome)
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0 , 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Text(Constantes.DATA_NASCIMENTO),
                      Text(_dataNascimento)
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0 , 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Text(Constantes.EMAIL),
                      Text(_email)
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0 , 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Text(Constantes.TELEFONE),
                      Text(_telefone)
                    ],
                  ),
                ),
                Divider(),
                Container(
                  alignment: FractionalOffset.center,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.lightbulb_outline,
                          color: _lights ? Colors.yellow.shade600 : Colors.black,
                          size: 60,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _lights = true;
                          });
                        },
                        child: Container(
                          color: Colors.yellow.shade600,
                          padding: const EdgeInsets.all(8),
                          child: const Text('TURN LIGHTS ON'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }

}
