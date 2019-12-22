import 'package:flutter/material.dart';

class Temas {
  static Theme dataHora(child) {
    return Theme(
      data: ThemeData(
          primaryColor: Colors.brown[900],
          accentColor: Colors.brown,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.accent,

          )
      ),
      child: child,
    );
  }

  static ThemeData principal(){
    return ThemeData(
        colorScheme: ColorScheme(
          primary: Colors.brown[900],
          secondary: Colors.brown,
          surface: Colors.brown[800],
          error: Colors.red,
          background: Colors.brown[500] ,
          brightness: Brightness.light,
          primaryVariant: Colors.brown[900],
          secondaryVariant: Colors.brown,
          onPrimary: Colors.brown[900],
          onSecondary: Colors.brown,
          onSurface: Colors.brown[800],
          onError: Colors.red,
          onBackground: Colors.brown[500],
        ),
        cursorColor:  Colors.brown[900],
        buttonTheme: ButtonThemeData(
          shape: OutlineInputBorder(),
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
          minWidth: 50,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.brown[900]
            ),
          ),
          suffixStyle:  TextStyle(
            color: Colors.brown[900],
            fontSize: 10,
          ),
          prefixStyle: TextStyle(
            color: Colors.brown[900],
          ),
          focusColor: Colors.brown[900],
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.brown[900],
                width: 0.0
            ),
          ),
          labelStyle: TextStyle(
              color: Colors.brown[900],
              fontSize: 15
          ),
        ),
        textTheme: TextTheme(

        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.brown[600]
        )
    );
  }
}