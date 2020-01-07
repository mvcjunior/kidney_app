import 'dart:io';

import 'package:flutter/material.dart';

enum Tipo { credito, debito }

class Utils {

  static const meses = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];

  static final  String BARRA = '/';
  static final  String ESPACO = ' ';
  static final  String DOIS_PONTOS = ':';

  static String formataData(DateTime data) {
    return formataDia(data) + BARRA +
        (data.month < 10 ? '0' + data.month.toString() : data.month.toString()) + BARRA +
        data.year.toString();
  }

  static String formataMes(DateTime data) {

    return meses[data.month-1].toUpperCase();
  }

  static String anoMesDia(DateTime data) {
    return data.year.toString() + formataMes(data) + formataDia(data);

  }

  static String formataDia(DateTime data) {
    return (data.day < 10 ?  '0' + data.day.toString() : data.day.toString());
  }

  static String formataHoraDateTime(DateTime data) {
    return (data.hour < 10 ?  '0' + data.hour.toString() : data.hour.toString()) + DOIS_PONTOS +
        (data.minute < 10 ? '0' + data.minute.toString() : data.minute.toString());
  }

  static String formataHora(TimeOfDay  hora) {
    return (hora.hour < 10 ?  '0' + hora.hour.toString() : hora.hour.toString()) + DOIS_PONTOS +
        (hora.minute < 10 ? '0' + hora.minute.toString() : hora.minute.toString());
  }

  static String formataDataHora (DateTime dataHora ) {
    return numero(dataHora.day) + ESPACO + meses[dataHora.month-1].substring(0,3).toUpperCase() + ESPACO + dataHora.year.toString() +
      ' ' + numero(dataHora.hour) + DOIS_PONTOS + numero(dataHora.minute);
  }

  static String formataPressao (int sistolica, int diastolica ) {
    return sistolica.toString() + ' / ' + diastolica.toString() + ' mmHg';
  }
  static String formataGlicemia (int glicemia) {
    return glicemia.toString() +  ' mg/dl';
  }

  static String numero(int numero) {
    return numero > 9 ? numero.toString() : '0' + numero.toString();
  }

  static DateTime dataHora (DateTime data, TimeOfDay hora ) {
    String dataString = data.toIso8601String();
    String horaString = hora.toString();
    String dataRetorno = dataString.substring(0, 11) +
        horaString.substring(10, 15) + ':00.000000';
    return DateTime.parse(dataRetorno);
  }

  int calculaIndice(int id, List lista) {
    for (int i=0;i < lista.length; i++)
      if (lista[i].id == id)
        return i;
    return 0;
  }

  static String intToData(int valor) {
    DateTime data = DateTime.fromMillisecondsSinceEpoch(valor);
    return formataData(data);
  }

  static String intToCurrency(int valor) {
    int inteiros = (valor / 100).truncate();
    StringBuffer inteirosString = StringBuffer();
    if (inteiros > 999) {
      int tamanho = inteiros.toString().length;
      inteirosString.write(inteiros.toString().substring(0,tamanho-3));
      inteirosString.write('.');
      inteirosString.write(inteiros.toString().substring(tamanho-3));
    } else {
      inteirosString.write(inteiros.toString());
    }
    int decimais = valor.remainder(100);
    return 'R\$ ' + inteirosString.toString() + ',' + (decimais < 9 ? '0' + decimais.toString() : decimais.toString()) ;
  }

  static String dataNowAAAAMMDDHHMMSS() {
    String dataHora = DateTime.now().toString();
    return dataHora.substring(0, 19).replaceAll(':', '').replaceAll('-', '').replaceAll(' ', '');
  }

  static String formataNomeArquivo(String caminho) {
    return caminho + BARRA + 'gastos_' + Utils.dataNowAAAAMMDDHHMMSS() + '.bkp';

  }

  static String formataMesAno(String mesAno) {
    int mes = int.parse(mesAno.substring(0,2));
    String ano = mesAno.substring(3);
    return meses[mes-1] + ' / ' + ano;
  }

  static String formataParcelado(int parcelas) {
    String parcelasx = parcelas.toString() + 'x';
    return parcelas != null && parcelas > 0 ? 'Parcelado em $parcelasx' : '';

  }

  static String voltaDiretorio(String diretorio) {

    return diretorio.lastIndexOf(BARRA) > 1 ? diretorio.substring(0, diretorio.lastIndexOf(BARRA)) : BARRA;

  }

  static List<int> defineDatasLancamentosFuturos(int dataInt, int diaPagamento, int melhorDia, int parcelas) {
    List<int> datas = List();
    DateTime data = DateTime.fromMillisecondsSinceEpoch(dataInt);

    int dia = diaPagamento != null && diaPagamento !=0 ? diaPagamento : data.day;
    int mes = data.month;
    int ano = data.year;
    int somaMes = somaMaisMeses(melhorDia, diaPagamento, data.day);

    for (int m=0; m < somaMes; m++ ) {
      mes++;
      if (mes > 12) {
        ano++;
        mes = 1;
      }
    }

    if (parcelas != null && parcelas > 1) {
      for (int i = 1; i <= parcelas; i++) {
        datas.add(DateTime(ano, mes, dia).millisecondsSinceEpoch);
        mes++;
        if (mes > 12) {
          ano++;
          mes = 1;
        }
      }
    } else {
      datas.add(DateTime(ano, mes, dia).millisecondsSinceEpoch);
    }

    return datas;
  }

  static int somaMaisMeses(int melhorDia, int diaPagamento, int diaLancamento) {
    int total = 0;
    if (melhorDia != null && melhorDia != 0) {
      if (melhorDia > diaPagamento) {
        total++;
      }
      if (diaLancamento >= melhorDia) {
        total++;
      }
    }
    return total;
  }
  static int defineValorLancamentosFuturos(int valor, int parcelas) {
    return parcelas != null && parcelas > 1 ? (valor / parcelas).toInt() : valor;
  }

  static String credito() {
    return Tipo.credito.toString();
  }

}