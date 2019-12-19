import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kidney_app/utils/constantes.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';


class PagePerfilEdicao extends StatefulWidget {
  final TextEditingController formato;
  final String cabecalho;
  final String valor;

  PagePerfilEdicao({this.formato, this.cabecalho, this.valor,
  Key key}) : super(key: key);

  @override
  _PagePerfilEdicao createState() => _PagePerfilEdicao(formato: this.formato,
      cabecalho: this.cabecalho, valor: this.valor );
}


class _PagePerfilEdicao extends State<PagePerfilEdicao> {
  final TextEditingController formato;
  final String cabecalho;
  final String valor;

  _PagePerfilEdicao({this.formato, this.cabecalho, this.valor, Key key});

  final _formKey = GlobalKey<FormState>();

  final List titulos = [
    'Informe seu CPF',
    'Informe seu NOME',
    'Informe sua DATA NASCIMENTO',
    'Informe seu EMAIL de contato',
    'Informe seu TELEFONE de contato',
  ];
  int ocorrencia;

  TextInputType tipoTeclado;

  @override
  void initState() {
    super.initState();
    ocorrencia = obtemOcorrencia(cabecalho);
    formato.text = valor;
    if (cabecalho == Constantes.TELEFONE || cabecalho == Constantes.CPF ||
        cabecalho == Constantes.DATA_NASCIMENTO)
      tipoTeclado = TextInputType.number;
    else
      tipoTeclado = TextInputType.text;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 40 , 0, 0),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 40 , 40, 30),
                  alignment: Alignment.bottomRight,
                  child: Text(titulos[ocorrencia],
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 30 , 0, 20),
                  alignment: Alignment.centerLeft,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 22
                      ),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide.none
                          )
                      ),
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: tipoTeclado,
                      controller: this.formato,
                      textAlign: TextAlign.start,
                      validator: (valor) {
                        if (valor.isEmpty) {
                          return 'Preencha a informação solicitada';
                        }
                        return null;
                      },
                    ),
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 80 , 20, 20),
                  alignment: Alignment.center,
                  child: MaterialButton(
                    minWidth: 400,
                    shape: OutlineInputBorder(),
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        _salvaInformacao(this.cabecalho, this.formato.text);
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text('Atualizar'),
                  )
                ),
              ],
            )
        )
    );
  }

  _salvaInformacao(String literal, String valor ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(literal, valor);

  }

  static int obtemOcorrencia (String cabecalho) {

    switch(cabecalho) {
      case 'cpf': return 0;
      case 'nome': return 1;
      case 'data nascimento': return 2;
      case 'email': return 3;
      case 'telefone': return 4;
    }

  }

}
