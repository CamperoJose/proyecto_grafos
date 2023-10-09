
List<int> hungarianAlgorithm2(List<List<int>> matrix) {
  List<int> result = [];
  for (int i = 0; i < matrix.length; i++) {
    if (todoCero(matrix[i])) {
      result.add(-1);
    } else {
      result.add(posMay(matrix[i]));
    }
  }

  return result;
}
bool todoCero(List<int> fila) {
  for (int i = 0; i < fila.length; i++) {
    if (fila[i] != 0) {
      return false;
    }
  }
  return true;
}

int posMay(List<int> fila) {
  int m = 0;
  for (int i = 0; i < fila.length; i++) {
    if (fila[i] > m && fila[i] != 0) {
      m = fila[i];
    }
  }
  return fila.indexOf(m);
}
