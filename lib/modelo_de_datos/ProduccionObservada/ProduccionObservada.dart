class DatosProduccionObervada {
  final int? id;
  final bool hasErrors;
  final bool hasSend;
  final int idregistro;
  final String Desvio;
  final int cantidadRetenida;
  final String AtributodeProductoNC;
  final String EstadodelProducto;
  final String ArranqueLinea;
  final int ReprocesoConforme;
  final int ReprocesoNoConforme;
  final String EstadodelProductoC;
  final String EstadodelProductoNC;

  const DatosProduccionObervada({
    this.id,
    required this.hasErrors,
    required this.hasSend,
    required this.idregistro,
    required this.Desvio,
    required this.cantidadRetenida,
    required this.AtributodeProductoNC,
    required this.EstadodelProducto,
    required this.ArranqueLinea,
    required this.ReprocesoConforme,
    required this.ReprocesoNoConforme,
    required this.EstadodelProductoC,
    required this.EstadodelProductoNC
  });

  factory DatosProduccionObervada.fromMap(Map<String, dynamic> map) {
    return DatosProduccionObervada(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == 1,
      hasSend: map['hasSend'] == 1,
      idregistro: map['idregistro'] as int,
      Desvio: map['Desvio'] as String,
      cantidadRetenida: map['cantidadRetenida'] as int,
      AtributodeProductoNC: map['AtributodeProductoNC'] as String,
      EstadodelProducto: map['EstadodelProducto'] as String,
      ArranqueLinea: map['ArranqueLinea'] as String,
      ReprocesoConforme: map['ReprocesoConforme'] as int,
      ReprocesoNoConforme: map['ReprocesoNoConforme'] as int,
      EstadodelProductoC: map['EstadodelProductoC'] as String,
      EstadodelProductoNC: map['EstadodelProductoNC'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'hasErrors': hasErrors ? 1 : 0,
      'hasSend': hasSend ? 1 : 0,
      'idregistro': idregistro,
      'Desvio': Desvio,
      'cantidadRetenida': cantidadRetenida,
      'AtributodeProductoNC': AtributodeProductoNC,
      'EstadodelProducto': EstadodelProducto,
      'ArranqueLinea': ArranqueLinea,
      'ReprocesoConforme': ReprocesoConforme,
      'ReprocesoNoConforme': ReprocesoNoConforme,
      'EstadodelProductoC': EstadodelProductoC,
      'EstadodelProductoNC': EstadodelProductoNC
    };
  }

  DatosProduccionObervada copyWith({
    int? id,
    bool? hasErrors,
    bool? hasSend,
    int? idregistro,
    String? Desvio, int? cantidadRetenida, String? AtributodeProductoNC, String? EstadodelProducto, String? ArranqueLinea, int? ReprocesoConforme, int? ReprocesoNoConforme, String? EstadodelProductoC, String? EstadodelProductoNC
  }) {
    return DatosProduccionObervada(
      id: id ?? this.id,
      hasErrors: hasErrors ?? this.hasErrors,
      hasSend: hasSend ?? this.hasSend,
      idregistro: idregistro ?? this.idregistro,
      Desvio: Desvio ?? this.Desvio,
      cantidadRetenida: cantidadRetenida ?? this.cantidadRetenida,
      AtributodeProductoNC: AtributodeProductoNC ?? this.AtributodeProductoNC,
      EstadodelProducto: EstadodelProducto ?? this.EstadodelProducto,
      ArranqueLinea: ArranqueLinea ?? this.ArranqueLinea,
      ReprocesoConforme: ReprocesoConforme ?? this.ReprocesoConforme,
      ReprocesoNoConforme: ReprocesoNoConforme ?? this.ReprocesoNoConforme,
      EstadodelProductoC: EstadodelProductoC ?? this.EstadodelProductoC,
      EstadodelProductoNC: EstadodelProductoNC ?? this.EstadodelProductoNC
    );
  }
}
