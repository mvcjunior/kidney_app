import 'package:flutter/material.dart';
import 'package:kidney_app/paginas/pages_view_home/view_informacoes.dart';
import 'package:kidney_app/paginas/pages_view_home/view_proximas_consultas.dart';
import 'package:kidney_app/paginas/pages_view_home/view_grafico_glicemia.dart';
import 'package:kidney_app/paginas/pages_view_home/view_grafico_pressao_arterial.dart';

class PageViewHome extends StatefulWidget {

  PageViewHome({Key key}) : super(key: key);

  @override
  _PageViewHome createState() => _PageViewHome();

}

class _PageViewHome extends State<PageViewHome> {

  _PageViewHome({Key key});

  final pageController = PageController(
    initialPage: 0,
  );

  int _pagina = 0;

  @override
  void initState() {
    super.initState();
  }



  Widget build(BuildContext context) {
   return Center(
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Card(
            color: Colors.white,
            child: Container(
              width: 350,
              height: 480,
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ViewInformacoes(),
                  ViewProximasConsultas(),
                  ViewGraficoGlicemia(),
                  ViewGraficoPressaoArterial()
                ],
                onPageChanged: (pagina) {
                  _pagina = pagina;
                  setState(() {

                  });
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icone(0),
                icone(1),
                icone(2),
                icone(3),
              ],
            ),
          )
        ],
      )
    );

  }


  Icon icone (int pagina) {
    double size = 9;
    return pagina != _pagina ?
          Icon(Icons.radio_button_unchecked, size: size)
        : Icon(Icons.brightness_1, size: size);
  }


}