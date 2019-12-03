import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PagePerfil extends StatefulWidget {

  PagePerfil({Key key}) : super(key: key);

  @override
  _PagePerfil createState() => _PagePerfil();
}


class _PagePerfil extends State<PagePerfil> {

  _PagePerfil({Key key});

  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = MaskedTextController(mask: '(00) 0000-00000');


  @override
  void initState() {
    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              }
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Form(
                key: _formKey,
                child: Column(
                    children: <Widget>[
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: nomeController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                        ),
                        //initialValue: '',
                        validator: (nome) {
                          if (nome.isEmpty) {
                            return 'Preencha seu nome';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                        ),
                        //initialValue: '',
                        validator: (nome) {
                          if (nome.isEmpty) {
                            return 'Preencha seu e-mail';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: telefoneController,
                        decoration: InputDecoration(
                          labelText: 'Telefone',
                        ),
                        validator: (nome) {
                          if (nome.isEmpty) {
                            return 'Preencha seu e-mail';
                          }
                          return null;
                        },
                      ),
                      RaisedButton(
                        child: Text('Atualizar'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                )
            )
        )
    );
  }
}
