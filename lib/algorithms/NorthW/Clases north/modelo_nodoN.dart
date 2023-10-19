class ModeloNodoN {
  String _id;//nombre
  double _x, _y, _radio;
  String _mensaje;
  ModeloNodoN(this._id, this._x, this._y, this._radio, this._mensaje);

  String get mensaje => _mensaje;

  String get id => _id;

  set mensaje(String value) {
    _mensaje = value;
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

    );
  }

  @override
  String toString() {
    return 'ModeloNodoN{id: $_id, x: $_x, y: $_y, radio: $_radio, mensaje: $_mensaje}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'x': x,
      'y': y,
      'radio': radio,
      'mensaje': mensaje,
    };
  }
}
