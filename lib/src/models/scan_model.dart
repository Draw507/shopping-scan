class ScanModel {
  int id;
  String tipo;
  String valor;
  String formato;
  String formatoNota;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
    this.formato,
    this.formatoNota,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
        formato: json["formato"],
        formatoNota: json["formatoNota"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
        "formato": formato,
        "formatoNota": formatoNota,
      };
}
