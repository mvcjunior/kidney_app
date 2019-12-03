import 'package:flutter/material.dart';

class PagePressaoArterial extends StatefulWidget {

  PagePressaoArterial({Key key}) : super(key: key);

  @override
  _PagePressaoArterial createState() => _PagePressaoArterial();
}


class _PagePressaoArterial extends State<PagePressaoArterial> {

  _PagePressaoArterial({Key key});

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(40, 30, 40, 0),
                      alignment: Alignment.center,
                      child: Column()
                  ),
                ]

            )
        )
    );
  }
}
