import 'package:flutter/material.dart';
import 'package:kidney_app/paginas/page_perfil.dart';
import 'package:kidney_app/paginas/page_glicemia.dart';
import 'package:kidney_app/paginas/page_lista_pressao_arterial.dart';

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
              color: Colors.lightGreenAccent,
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
              Navigator.of(context).push(_createRouteOne());
            },
          ),
          ListTile(
            title: Text('Alarmes'),
            onTap: () {
              Navigator.of(context).push(_createRouteOne());
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
      pageBuilder: (context, animation, secondaryAnimation) => PageGlicemia(),
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
