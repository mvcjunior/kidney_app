import 'package:flutter/material.dart';
import 'package:kidney_app/paginas/page_lista_agenda.dart';
import 'package:kidney_app/paginas/page_lista_glicemia.dart';
import 'package:kidney_app/paginas/page_lista_medicacao.dart';
import 'package:kidney_app/paginas/perfil/page_perfil.dart';
import 'package:kidney_app/paginas/page_lista_pressao_arterial.dart';
import 'package:kidney_app/utils/constantes.dart';

class MenuDrawer extends StatelessWidget {
  static final begin = Offset(0.0, 1.0);
  static final end = Offset.zero;
  static final curve = Curves.ease;
  static final tween = Tween(begin: begin, end: end,  ).chain(CurveTween(curve: curve));

  MenuDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: <Widget>[
          DrawerHeader(
            child: Text('Informações do Paciente'),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              color: Constantes.COR_500,
            ),
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              Navigator.of(context).push(_createRoutePagePerfil());
            },
          ),
          ListTile(
            title: Text('Agenda'),
            onTap: () {
              Navigator.of(context).push(_createRoutePageAgenda());
            },
          ),
          ListTile(
            title: Text('Alarmes Medicações'),
            onTap: () {
              Navigator.of(context).push(_createRoutePageMedicacao());
            },
          ),
          ListTile(
            title: Text('Pressão Arterial'),
            onTap: () {
              Navigator.of(context).push(_createRoutePressaoArterial());
            },
          ),
          ListTile(
            title: Text('Glicemia Capilar'),
            onTap: () {
              Navigator.of(context).push(_createRoutePageGlicemia());
            },
          ),
        ],
      ),
    );
  }

  Route _createRoutePagePerfil() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PagePerfil(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRoutePressaoArterial() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PageListaPressaoArterial(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRoutePageGlicemia() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PageListaGlicemia(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRoutePageAgenda() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PageListaAgenda(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _createRoutePageMedicacao() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PageListaMedicacao(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


  Route _createRouteOne() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Center(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}
