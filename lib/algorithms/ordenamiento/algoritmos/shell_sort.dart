List<int> shellSort(List<int> arr) {
  int n = arr.length;
  List<int> sortedList = List.from(arr);

  // Definir el espacio inicial (gap)
  int gap = n ~/ 3;

  while (gap > 0) {
    for (int i = gap; i < n; i++) {
      int temp = sortedList[i];
      int j = i;

      // Comparar elementos a una distancia de 'gap' y realizar intercambios si es necesario
      while (j >= gap && sortedList[j - gap] > temp) {
        sortedList[j] = sortedList[j - gap];
        j -= gap;
      }

      sortedList[j] = temp;
    }

    // Reducir el espacio (gap) en cada iteración
    gap = gap ~/ 3;
  }

  return sortedList;
}
