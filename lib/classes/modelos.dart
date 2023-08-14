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

  bool get ida => ida;

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

class ModeloUnion {
  String idNodoInicial, idNodoFinal;
  double _xinicio, _xfinal;
  double _yinicio, _yfinal;
  String peso;
  bool _ida;

  ModeloUnion(this.idNodoInicial, this.idNodoFinal, this._xinicio,
      this._yinicio, this._xfinal, this._yfinal, this.peso, this._ida);

  get yfinal => _yfinal;
  get yinicio => _yinicio;
  get xfinal => _xfinal;
  get xinicio => _xinicio;
  get ida => _ida;

  set yfinal(value) {
    _yfinal = value;
  }

  set yinicio(value) {
    _yinicio = value;
  }

  set xfinal(value) {
    _xfinal = value;
  }

  set xinicio(value) {
    _xinicio = value;
  }
}
