import 'package:flutter/material.dart';
import 'package:kidney_app/paginas/perfil/page_perfil_edicao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kidney_app/utils/constantes.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PagePerfil extends StatefulWidget {

  PagePerfil({Key key}) : super(key: key);

  @override
  _PagePerfil createState() => _PagePerfil();
}


class _PagePerfil extends State<PagePerfil> {

  _PagePerfil({Key key});

  String _nome;
  String _cpf;
  String _email;
  String _telefone;
  String _dataNascimento;

  TextEditingController _cpfFormatter = MaskedTextController(mask: '000.000.000-00');
  TextEditingController _telefoneFormatter = MaskedTextController(mask: '(00) 00000-0000');
  TextEditingController _dataFormatter = MaskedTextController(mask: '00/00/0000');
  TextEditingController _textFormatter = TextEditingController();

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
                  padding: EdgeInsets.fromLTRB(10, 40 , 0, 0),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0 , 0, 20),
                  alignment: Alignment.center,
                  child: Text(
                      'PERFIL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                atributoPerfil(Constantes.CPF, _cpf, _cpfFormatter),
                atributoPerfil(Constantes.NOME, _nome, _textFormatter),
                atributoPerfil(Constantes.DATA_NASCIMENTO, _dataNascimento, _dataFormatter),
                atributoPerfil(Constantes.EMAIL, _email, _textFormatter),
                atributoPerfil(Constantes.TELEFONE, _telefone, _telefoneFormatter),
              ],
            )
        )
    );
  }

  Widget atributoPerfil(String cabecalho, String valor, TextEditingController formato) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PagePerfilEdicao(
                cabecalho: cabecalho, valor: valor, campo: cabecalho, formato: formato,
              )),
            );
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  cabecalho.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(valor)
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

}
