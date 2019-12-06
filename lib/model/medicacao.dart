import 'package:flutter/material.dart';

class Medicacao {
  final int id;
  final TimeOfDay hora;
  final String nome;
  final int unidade;
  final int quantidade;
  final DateTime dataHoraInclusao;
  final DateTime dataHoraAlteracao;


  Medicacao({this.id, this.hora, this.nome, this.unidade, this.quantidade,
    this.dataHoraInclusao, this.dataHoraAlteracao});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hora': hora,
      'nome': nome,
      'unidade': unidade,
      'quantidade': quantidade,
      'data_hora_inclusao': dataHoraInclusao,
      'data_hora_alteracao' : dataHoraAlteracao
    };
  }
  @override
  String toString() {
    // TODO: implement toString
    return '{id: $id, nome: $nome, hora: $hora, unidade: $unidade, quantidade: $quantidade, '
        'data_hora_inclusao: $dataHoraInclusao,'
        'data_hora_alteracao: $dataHoraAlteracao }';
  }

  Medicacao.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'],
        hora = json['hora'],
        nome = json['nome'],
        unidade = json['unidade'],
        quantidade = json['quantidade'],
        dataHoraInclusao = json['data_hora_inclusao'],
        dataHoraAlteracao = json['data_hora_alteracao'];

  String toJson() {
    return 'Medicacao: {"id": $id, "hora": "$hora", '
        '"nome": $nome, '
        '"data_hora_inclusao": "$dataHoraInclusao", "data_hora_alteracao": '
        '"$dataHoraAlteracao"  }';

  }
}
