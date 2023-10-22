class Nodo {
  int _dato;
  Nodo? _izquierda;
  Nodo? _derecha;
  
  Nodo(int elemento) : _dato = elemento {
    _dato = elemento;
    _izquierda = null;
    _derecha = null;
  }

  Nodo insertar(Nodo? raiz, Nodo nuevo) {
    if (raiz == null) {
      raiz = nuevo;
    } else if (raiz.dato > nuevo.dato) {
      raiz.izquierda = insertar(raiz.izquierda, nuevo);
    } else if (raiz.dato < nuevo.dato) {
      raiz.derecha = insertar(raiz.derecha, nuevo);
    }
    return raiz;
  }

  int get dato {
    return _dato;
  }

  set dato(int elemento) {
    this._dato = elemento;
  }
  
  Nodo? get izquierda {
    return _izquierda;
  }

  set izquierda(Nodo? nodo) {
    this._izquierda = nodo;
  }

  Nodo? get derecha {
    return _derecha;
  }

  set derecha(Nodo? nodo) {
    this._derecha = nodo;
  }
}
