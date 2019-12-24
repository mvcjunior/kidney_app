import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidney_app/utils/constantes.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

class ViewInformacoes extends StatefulWidget {
  ViewInformacoes({Key key}) : super(key: key);

  @override
  _ViewInformacoes createState() => _ViewInformacoes();
}

class _ViewInformacoes extends State<ViewInformacoes> {

  _ViewInformacoes({Key key});


  @override
  void initState() {
    super.initState();
  }



  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    RefreshIndicatorMode refreshState;
    double pulledExtent = 0;
    double refreshTriggerPullDistance = 0;
    double refreshIndicatorExtent = 0;
    const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: 80.0,
          floating: true,
          pinned: true,
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
              background: Text(
                  'Informações',
                style: TextStyle(fontSize: 20),
              )),
        ),
        //SliverPersistentHeader (
          //floating: true,
          //pinned: true,
          //delegate: _SliverAppBarDelegate(),
        //),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                  });
                },
                child: Container(
                  child: Card(
                      elevation: 5,
                      color: Constantes.COR_200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                              'Blablabla bla blal blallb alblal bla bla bla blablbla bla',
                            style: TextStyle(color: Constantes.COR_LETRA, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              'blablbla bla bla bla bla bla bla bla blablbla bla bla bla bla bla bla bla blablbla bla bla bla bla bla bla bla'
                                  'blablbla bla bla bla bla bla bla bla blablbla bla bla bla bla bla bla bla blablbla bla bla bla bla bla bla bla',
                            style: TextStyle(color: Constantes.COR_LETRA, fontSize: 15),
                          )
                        ],
                      )
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}

