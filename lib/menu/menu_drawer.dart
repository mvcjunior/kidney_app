import 'package:flutter/material.dart';

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
            child: Text('Perfil'),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
            ),
          ),
          ListTile(
            title: Text('Informações do Paciente'),
            onTap: () {
              Navigator.of(context).push(_createRouteOne());
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
            title: Text('Registros Pressão Arterial'),
            onTap: () {
              Navigator.of(context).push(_createRouteOne());
            },
          ),
          ListTile(
            title: Text('Registros Glicemia Capilar'),
            onTap: () {
              Navigator.of(context).push(_createRouteOne());
            },
          ),
        ],
      ),
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
