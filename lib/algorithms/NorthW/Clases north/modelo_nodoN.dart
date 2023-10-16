class ModeloNodoN {
  String _id;//nombre
  double _x, _y, _radio;
  String _mensaje;
  int _oferta; // Campo de oferta
  int _demanda; // Campo de demanda

  ModeloNodoN(this._id, this._x, this._y, this._radio, this._mensaje, this._oferta, this._demanda);

  String get mensaje => _mensaje;

  String get id => _id;

  set mensaje(String value) {
    _mensaje = value;
  }

  int get oferta => _oferta;

  set oferta(int value) {
    _oferta = value;
  }

  int get demanda => _demanda;

  set demanda(int value) {
    _demanda = value;
  }

  get radio => _radio;

  set radio(value) {
    _radio = value;
  }

  get y => _y;

  set y(value) {
    _y = value;
  }

  get x => _x;

  set x(value) {
    _x = value;
  }

  static ModeloNodoN fromJson(Map<String, dynamic> json) {
    return ModeloNodoN(
      json['id'],
      json['x'],
      json['y'],
      json['radio'],
      json['mensaje'],
      json['oferta'], // Asigna el valor de oferta desde el JSON
      json['demanda'], // Asigna el valor de demanda desde el JSON
    );
  }

  @override
  String toString() {
    return 'ModeloNodoN{id: $_id, x: $_x, y: $_y, radio: $_radio, mensaje: $_mensaje, oferta: $_oferta, demanda: $_demanda}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'x': x,
      'y': y,
      'radio': radio,
      'mensaje': mensaje,
      'oferta': oferta, // Agrega el campo de oferta al JSON
      'demanda': demanda, // Agrega el campo de demanda al JSON
    };
  }
}
