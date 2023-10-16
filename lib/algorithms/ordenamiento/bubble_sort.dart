List<int> bubbleSort(List<int> arr) {
  int n = arr.length;
  List<int> sortedList = List.from(arr);
  bool swapped;

  do {
    swapped = false;
    for (int i = 0; i < n - 1; i++) {
      if (sortedList[i] > sortedList[i + 1]) {
        int temp = sortedList[i];
        sortedList[i] = sortedList[i + 1];
        sortedList[i + 1] = temp;
        swapped = true;
      }
    }
  } while (swapped);

  return sortedList;
}
