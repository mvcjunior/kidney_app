class Glicemia {
  final int id;
  final DateTime dataHora;
  final int indiceGlicemico;
  final DateTime dataHoraInclusao;
  final DateTime dataHoraAlteracao;


  Glicemia({this.id, this.dataHora, this.indiceGlicemico,
    this.dataHoraInclusao, this.dataHoraAlteracao});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data_hora': dataHora,
      'indice_glicemico': indiceGlicemico,
      'data_hora_inclusao': dataHoraInclusao,
      'data_hora_alteracao' : dataHoraAlteracao
    };
  }
  @override
  String toString() {
    // TODO: implement toString
    return '{id: $id, data_hora: $dataHora, indice_glicemico: $indiceGlicemico, '
        'data_hora_inclusao: $dataHoraInclusao,'
        'data_hora_alteracao: $dataHoraAlteracao }';
  }

  Glicemia.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'],
        dataHora = json['data_hora'],
        indiceGlicemico = json['indice_glicemico'],
        dataHoraInclusao = json['data_hora_inclusao'],
        dataHoraAlteracao = json['data_hora_alteracao'];

  String toJson() {
    return 'Glicemia: {"id": $id, "data_hora": "$dataHora", '
        '"indice_glicemico": $indiceGlicemico, '
        '"data_hora_inclusao": "$dataHoraInclusao", "data_hora_alteracao": '
        '"$dataHoraAlteracao"  }';

  }
}
