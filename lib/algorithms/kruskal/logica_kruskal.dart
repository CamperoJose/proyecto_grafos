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
      if (matrix[i][j] != "0") {
        puentes.add(
            CaminoKrus(matrix[i][0], matrix[0][j], int.parse(matrix[i][j])));
      }
    }
  }
  return puentes;
}

class Kruskal {
  List<String> vertices;
  List<CaminoKrus> puentes;

  Kruskal(this.vertices, this.puentes);

  List<CaminoKrus> kruskalMin() {
    puentes.sort((a, b) => a.peso.compareTo(b.peso));
    var padre = HashMap<String, String>();
    var rango = HashMap<String, int>();
    List<CaminoKrus> minimizacion = [];
    for (var vert in vertices) {
      padre[vert] = vert;
      rango[vert] = 0;
    }
    for (var puente in puentes) {
      String x = buscar(padre, puente.inicio);
      String y = buscar(padre, puente.destino);

      if (x != y) {
        minimizacion.add(puente);
        union(padre, rango, x, y);
      }
    }
    return minimizacion;
  }

  List<CaminoKrus> kruskalMax() {
    puentes.sort((a, b) =>
        b.peso.compareTo(a.peso)); // Ordenar de forma descendente por peso
    var padre = HashMap<String, String>();
    var rango = HashMap<String, int>();
    List<CaminoKrus> maximizacion = [];

    for (var vert in vertices) {
      padre[vert] = vert;
      rango[vert] = 0;
    }

    for (var puente in puentes) {
      String x = buscar(padre, puente.inicio);
      String y = buscar(padre, puente.destino);

      if (x != y) {
        maximizacion.add(puente);
        union(padre, rango, x, y);
      }
    }

    return maximizacion;
  }

  String buscar(HashMap<String, String> padre, String vert) {
    if (padre[vert] == vert) {
      return vert;
    }
    return buscar(padre, padre[vert]!);
  }

  void union(HashMap<String, String> padre, HashMap<String, int> rango,
      String x, String y) {
    String raizX = buscar(padre, x);
    String raizY = buscar(padre, y);
    if (rango[raizX]!.compareTo(rango[raizY]!) < 0) {
      padre[raizX] = raizY;
    } else if (rango[raizX]!.compareTo(rango[raizY]!) > 0) {
      padre[raizY] = raizX;
    } else {
      padre[raizY] = raizX;
      rango[raizX] = rango[raizX]! + 1;
    }
  }
}
