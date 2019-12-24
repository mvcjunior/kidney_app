import 'package:flutter/material.dart';
import 'package:kidney_app/utils/constantes.dart';

class Temas {
  static Theme dataHora(child) {
    return Theme(
      data: ThemeData(
          primaryColor: Constantes.COR_900,
          accentColor: Constantes.COR,
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
          primary: Constantes.COR_900,
          secondary: Constantes.COR,
          surface: Constantes.COR_800,
          error: Constantes.COR_ERRO,
          background: Constantes.COR_500 ,
          brightness: Brightness.light,
          primaryVariant: Constantes.COR_900,
          secondaryVariant: Constantes.COR,
          onPrimary: Constantes.COR_900,
          onSecondary: Constantes.COR,
          onSurface: Constantes.COR_800,
          onError: Constantes.COR_ERRO,
          onBackground: Constantes.COR_500,
        ),
        cursorColor:  Constantes.COR_900,
        buttonTheme: ButtonThemeData(
          shape: OutlineInputBorder(),
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
          minWidth: 50,
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Constantes.COR_900
            ),
          ),
          suffixStyle:  TextStyle(
            color: Constantes.COR_900,
            fontSize: 10,
          ),
          prefixStyle: TextStyle(
            color: Constantes.COR_900,
          ),
          focusColor: Constantes.COR_900,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Constantes.COR_900,
                width: 0.0
            ),
          ),
          labelStyle: TextStyle(
              color: Constantes.COR_900,
              fontSize: 15
          ),
        ),
        textTheme: TextTheme(

        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Constantes.COR_600
        )
    );
  }
}