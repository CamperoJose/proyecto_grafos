List<int> insertionSort(List<int> arr) {
  int n = arr.length;
  List<int> sortedList = List.from(arr);

  for (int i = 1; i < n; i++) {
    int key = sortedList[i];
    int j = i - 1;

    while (j >= 0 && sortedList[j] > key) {
      sortedList[j + 1] = sortedList[j];
      j--;
    }

    sortedList[j + 1] = key;
  }

  return sortedList;
}
