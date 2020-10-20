class ProductoModel {
  int id;
  String uuid;
  String tipo;
  String valor;
  String formato;
  String formatoNota;
  String establecimiento;
  String producto;
  double precio;
  String estado;

  ProductoModel(
      {this.id,
      this.uuid,
      this.tipo,
      this.valor,
      this.formato,
      this.formatoNota,
      this.establecimiento,
      this.producto,
      this.precio,
      this.estado});

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
      id: json["id"],
      uuid: json["uuid"],
      tipo: json["tipo"],
      valor: json["valor"],
      formato: json["formato"],
      formatoNota: json["formatoNota"],
      establecimiento: json["establecimiento"],
      producto: json["producto"],
      precio: json["precio"],
      estado: json["estado"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "tipo": tipo,
        "valor": valor,
        "formato": formato,
        "formatoNota": formatoNota,
        "establecimiento": establecimiento,
        "producto": producto,
        "precio": precio,
        "estado": estado
      };
}
