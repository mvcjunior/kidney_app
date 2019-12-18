import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kidney_app/utils/constantes.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';


class PagePerfilEdicao extends StatefulWidget {
  final TextEditingController formato;
  final String cabecalho;
  final String valor;
  final String campo;
  PagePerfilEdicao({this.formato, this.cabecalho, this.valor,
    this.campo, Key key}) : super(key: key);

  @override
  _PagePerfilEdicao createState() => _PagePerfilEdicao(formato: this.formato,
      cabecalho: this.cabecalho, valor: this.valor, campo: this.campo );
}


class _PagePerfilEdicao extends State<PagePerfilEdicao> {
  final TextEditingController formato;
  final String cabecalho;
  final String valor;
  final String campo;

  _PagePerfilEdicao({this.formato, this.cabecalho, this.valor, this.campo, Key key});

  TextInputType tipoTeclado;

  @override
  void initState() {
    super.initState();
    print(this.valor);
    print(this.formato);
    formato.text = valor;
    if (campo == Constantes.TELEFONE || campo == Constantes.CPF ||
      campo == Constantes.DATA_NASCIMENTO)
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
                  padding: EdgeInsets.fromLTRB(20, 0 , 0, 20),
                  alignment: Alignment.center,
                  child: TextFormField(
                    decoration: InputDecoration(

                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none
                      )
                    ),
                    autofocus: true,
                    keyboardType: tipoTeclado,
                    controller: this.formato,
                    textAlign: TextAlign.center,
                    validator: (valor) {
                      if (valor.isEmpty) {
                        return 'Preencha a informação solicitada';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0 , 0, 20),
                  alignment: Alignment.center,
                  child: OutlineButton(
                    onPressed: (){
                      _salvaInformacao(this.campo, this.formato.text);
                      Navigator.pop(context);
                    },
                    child: Text('Salvar'),
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

}
