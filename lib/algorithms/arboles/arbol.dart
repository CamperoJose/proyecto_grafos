import 'nodo.dart';
import 'dart:math';

class Arbol {
  Nodo? _raiz;

  void insertarNodo(int elemento) {
    Nodo nuevo = Nodo(elemento);
    if (_raiz == null) {
      _raiz = nuevo;
    } else {
      _raiz = nuevo.insertar(_raiz, nuevo);
    }
  }

  int altura(Nodo n) {
    int altder = (n.derecha == null ? 0 : 1 + altura(n.derecha!));
    int altizq = (n.izquierda == null ? 0 : 1 + altura(n.izquierda!));
    return max(altder, altizq);
  }

  void resetArbol() {
    _raiz = null;
  }

  Nodo? get raiz {
    return _raiz;
  }

  set raiz(Nodo? n) {
    _raiz = n;
  }

  String inOrder(Nodo? nodo) {
    if (nodo != null) {
      return inOrder(nodo.izquierda) +
          nodo.dato.toString() +
          ", " +
          inOrder(nodo.derecha);
    }
    return "";
  }

  String preOrder(Nodo? nodo) {
    if (nodo != null) {
      return nodo.dato.toString() +
          ", " +
          preOrder(nodo.izquierda) +
          preOrder(nodo.derecha);
    }
    return "";
  }

  String postOrder(Nodo? nodo) {
    if (nodo != null) {
      return postOrder(nodo.izquierda) +
          postOrder(nodo.derecha) +
          nodo.dato.toString() +
          ", ";
    }
    return "";
  }
}
