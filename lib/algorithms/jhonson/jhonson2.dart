List<int> johnsonAlgorithm(List<List<int>> adjacencyMatrix) {
  final int n = adjacencyMatrix.length;
  final List<int> earlyTimes = List<int>.filled(n, 0);
  final List<int> lateTimes = List<int>.filled(n, 0);
  final List<List<int?>> slacks = List.generate(n, (i) => List<int?>.filled(n, null));

  // Calculate early times
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (adjacencyMatrix[i][j] != 0) {
        earlyTimes[j] = (earlyTimes[j] >
                (earlyTimes[i] + adjacencyMatrix[i][j]))
            ? earlyTimes[j]
            : (earlyTimes[i] + adjacencyMatrix[i][j]);
      }
    }
  }

  // Calculate late times
  for (int i = n - 1; i >= 0; i--) {
    for (int j = n - 1; j >= 0; j--) {
      if (adjacencyMatrix[i][j] != 0) {
        if (lateTimes[j] == 0) {
          lateTimes[j] = earlyTimes[j];
        }
        lateTimes[i] = (lateTimes[i] == 0)
            ? (lateTimes[j] - adjacencyMatrix[i][j])
            : (lateTimes[i] <
                    (lateTimes[j] - adjacencyMatrix[i][j]))
                ? lateTimes[i]
                : (lateTimes[j] - adjacencyMatrix[i][j]);
      }
    }
  }

  // Calculate slacks
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (adjacencyMatrix[i][j] != 0) {
        slacks[i][j] = lateTimes[j] - earlyTimes[i] - adjacencyMatrix[i][j];
      }
    }
  }

  // Return slacks and times as a matrix and vectors, respectively
  return earlyTimes;
}

