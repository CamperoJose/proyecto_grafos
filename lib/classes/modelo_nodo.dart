class ModeloNodo {
  String _id;
  double _x, _y, _radio;
  String _mensaje;

  ModeloNodo(this._id, this._x, this._y, this._radio, this._mensaje);

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

  @override
  String toString() {
    return 'ModeloNodo{_x: $_x, _y: $_y, _radio: $_radio, _mensaje: $_mensaje}';
  }
}