import 'dart:collection';

class CaminoKrus {
  String inicio;
  String destino;
  int peso;

  CaminoKrus(this.inicio, this.destino, this.peso);
}

List<CaminoKrus> matrizToLista(List<List<String>> matrix) {
  List<CaminoKrus> puentes = [];
  int filas = matrix.length;
  int cols = matrix[0].length;

  for (int i = 1; i < filas; i++) {
    for (int j = i + 1; j < cols; j++) {
      var value = matrix[i][j];
      if (value != "0" && value != "-1") {
        int? peso = int.tryParse(value);
        if (peso == null) {
          throw FormatException(
              "Valor no numérico encontrado en la matriz: $value");
        }
        puentes.add(CaminoKrus(matrix[i][0], matrix[0][j], peso));
      }
    }
  }
  return puentes;
}

class Kruskal {
  List<String> vertices;
  List<CaminoKrus> puentes;

  Kruskal(this.vertices, this.puentes) {
    // Validamos que todos los puentes hagan referencia a vértices existentes
    for (var puente in puentes) {
      if (!vertices.contains(puente.inicio) ||
          !vertices.contains(puente.destino)) {
        throw ArgumentError("Puente hace referencia a un vértice inexistente");
      }
    }
  }

  List<CaminoKrus> kruskalMin() {
    puentes.sort((a, b) => a.peso.compareTo(b.peso));
    return _kruskal();
  }

  List<CaminoKrus> kruskalMax() {
    puentes.sort((a, b) => b.peso.compareTo(a.peso)); // Descendente por peso
    return _kruskal();
  }

  List<CaminoKrus> _kruskal() {
    var padre = HashMap<String, String>();
    var rango = HashMap<String, int>();
    List<CaminoKrus> arbolAbarcador = [];

    for (var vert in vertices) {
      padre[vert] = vert;
      rango[vert] = 0;
    }

    for (var puente in puentes) {
      String x = buscar(padre, puente.inicio);
      String y = buscar(padre, puente.destino);

      if (x != y) {
        arbolAbarcador.add(puente);
        union(padre, rango, x, y);
      }
    }

    return arbolAbarcador;
  }

  String buscar(HashMap<String, String> padre, String vert) {
    while (vert != padre[vert]) {
      // Aseguramos que padre[vert] no es nulo con '!'
      String next = padre[vert]!;
      // Comprobamos y actualizamos el padre de 'vert' si 'next' no es nulo
      padre[vert] =
          padre[next] ?? next; // Proporcionamos 'next' como valor por defecto
      vert = next;
    }
    return vert;
  }

  void union(HashMap<String, String> padre, HashMap<String, int> rango,
      String x, String y) {
    String raizX = buscar(padre, x);
    String raizY = buscar(padre, y);
    if (raizX != raizY) {
      if (rango[raizX]! < rango[raizY]!) {
        padre[raizX] = raizY;
      } else {
        padre[raizY] = raizX;
        if (rango[raizX] == rango[raizY]) {
          rango[raizX] = rango[raizX]! + 1;
        }
      }
    }
  }
}
