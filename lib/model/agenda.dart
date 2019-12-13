class Agenda {
  final int id;
  final DateTime dataHora;
  final String local;
  final String evento;
  final String tipoEvento;
  final DateTime dataHoraInclusao;
  final DateTime dataHoraAlteracao;


  Agenda({this.id, this.dataHora, this.local, this.evento,
    this.tipoEvento, this.dataHoraInclusao, this.dataHoraAlteracao});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data_hora': dataHora,
      'local': local,
      'evento': evento,
      'tipo_evento': tipoEvento,
      'data_hora_inclusao': dataHoraInclusao,
      'data_hora_alteracao' : dataHoraAlteracao
    };
  }
  @override
  String toString() {
    // TODO: implement toString
    return '{id: $id, data_hora: $dataHora, local: $local, '
        'evento: $evento, tipo_evento: $tipoEvento, data_hora_inclusao: $dataHoraInclusao,'
        'data_hora_alteracao: $dataHoraAlteracao }';
  }

  Agenda.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'],
        dataHora = json['data_hora'],
        local = json['local'],
        evento = json['evento'],
        tipoEvento = json['tipo_evento'],
        dataHoraInclusao = json['data_hora_inclusao'],
        dataHoraAlteracao = json['data_hora_alteracao'];

  String toJson() {
    return 'Agenda: {"id": $id, "data_hora": "$dataHora", '
        '"local": "$local", "evento": "$evento", "tipo_evento": $tipoEvento, '
        '"data_hora_inclusao": "$dataHoraInclusao", "data_hora_alteracao": '
        '"$dataHoraAlteracao"  }';

  }
}
