class ModeloArista {
  String idNodoInicial, idNodoFinal;
  double _xinicio, _xfinal;
  double _yinicio, _yfinal;
  String peso;
  bool _ida;
  bool dirigido;

  ModeloArista(this.idNodoInicial, this.idNodoFinal, this._xinicio,
      this._yinicio, this._xfinal, this._yfinal, this.peso, this._ida, this.dirigido);

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

  @override
  String toString() {
    return 'ModeloArista{idNodoInicial: $idNodoInicial, idNodoFinal: $idNodoFinal, peso: $peso, _ida: $_ida}';
  }

  toJson(){
    return {
      'idNodoInicial': idNodoInicial,
      'idNodoFinal': idNodoFinal,
      'xinicio': _xinicio,
      'xfinal': _xfinal,
      'yinicio': _yinicio,
      'yfinal': _yfinal,
      'peso': peso,
      'ida': _ida,
      'dirigido': dirigido,
    };
  }
}
