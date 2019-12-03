class PressaoArterial {
  final int id;
  final DateTime dataHora;
  final int sistolica;
  final int diastolica;

  PressaoArterial({this.id, this.dataHora, this.sistolica, this.diastolica});
  //Categoria(this.id, this.descricaoCategoria);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data_hora': dataHora,
      'sistolica': sistolica,
      'diastolica': diastolica
    };
  }
  @override
  String toString() {
    // TODO: implement toString
    return '{id: $id, data_hora: $dataHora, sistolica: $sistolica, '
        'diastolica: $diastolica }';
  }

  PressaoArterial.fromMappedJson(Map<String, dynamic> json)
      : id = json['id'],
        dataHora = json['data_hora'],
        sistolica = json['sistolica'],
        diastolica = json['diastolica'];

  String toJson() {
    return 'PressaoArterial: {"id": $id, "data_hora": "$dataHora", '
        '"sistolica": $sistolica , "diastolica": $diastolica }';

  }
}
