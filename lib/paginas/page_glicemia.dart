import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PageGlicemia extends StatefulWidget {

  PageGlicemia({Key key}) : super(key: key);

  @override
  _PageGlicemia createState() => _PageGlicemia();
}


class _PageGlicemia extends State<PageGlicemia> {

  _PageGlicemia({Key key});

  final _formKey = GlobalKey<FormState>();
  final horaController = TextEditingController();
  final dataController = TextEditingController();
  final glicemiaController = TextEditingController();


  @override
  void initState() {
    super.initState();

  }

  Widget build(BuildContext context2) {
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
                        controller: horaController,
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
                        controller: dataController,
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
                        controller: glicemiaController,
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
