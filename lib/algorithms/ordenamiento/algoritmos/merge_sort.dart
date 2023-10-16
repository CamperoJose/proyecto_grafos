List<int> mergeSort(List<int> arr) {
  if (arr.length <= 1) {
    return arr;
  }

  List<int> merge(List<int> left, List<int> right) {
    List<int> result = [];
    int leftIndex = 0, rightIndex = 0;

    while (leftIndex < left.length && rightIndex < right.length) {
      if (left[leftIndex] < right[rightIndex]) {
        result.add(left[leftIndex]);
        leftIndex++;
      } else {
        result.add(right[rightIndex]);
        rightIndex++;
      }
    }

    return result + left.sublist(leftIndex) + right.sublist(rightIndex);
  }

  int mid = arr.length ~/ 2;
  List<int> left = arr.sublist(0, mid);
  List<int> right = arr.sublist(mid);

  left = mergeSort(left);
  right = mergeSort(right);

  return merge(left, right);
}

