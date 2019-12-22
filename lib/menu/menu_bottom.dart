import 'package:flutter/material.dart';


class MenuBottom extends StatefulWidget {

  MenuBottom({Key key}) : super(key: key);

  @override
  _MenuBottom createState() => _MenuBottom();
}


class _MenuBottom extends State<MenuBottom> {
  int _selectedIndex = 0;
  static final begin = Offset(0.0, 1.0);
  static final end = Offset.zero;
  static final curve = Curves.ease;
  static final tween = Tween(begin: begin, end: end,  ).chain(CurveTween(curve: curve));

  _MenuBottom({Key key});

  List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text('1'),
    ),
    Center(),
    Center(),
    Center()
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text('Agenda'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          title: Text('Medicação'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.accessibility_new),
          title: Text('Imunosupressores'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          title: Text('Dúvidas'),
        ),
      ],
      currentIndex: _selectedIndex,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.brown[500],
      backgroundColor: Colors.brown[900],
      elevation: 10,
      selectedItemColor: Colors.brown[900],
      unselectedFontSize: 0,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).push(_createRouteOne(_selectedIndex));
    });
  }

  Route _createRouteOne(int selectIndex) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => _widgetOptions[selectIndex],
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

}
