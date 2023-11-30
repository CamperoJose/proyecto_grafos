void main() {
  List<List<int>> matrix = [
    [0, 0, 0, 0, 6],
    [0, 0, 0, 0, 8],
    [0, 0, 0, 0, 10],
    [4, 8, 8, 4, -1]
  ];

  var solutions = findAllSolutions(matrix);
  print("Cantidad de soluciones: ${solutions.length}");
  for (var solution in solutions) {
    printMatrix(solution);
    print('');
  }
}

List<List<List<int>>> findAllSolutions(List<List<int>> matrix) {
  List<List<List<int>>> solutions = [];
  solve(matrix, 0, 0, solutions);
  return solutions;
}

void solve(List<List<int>> matrix, int row, int col, List<List<List<int>>> solutions) {
  if (row == matrix.length - 1) {
    if (isValidSolution(matrix)) {
      solutions.add(cloneMatrix(matrix));
    }
    return;
  }

  int nextRow = col == matrix[0].length - 2 ? row + 1 : row;
  int nextCol = col == matrix[0].length - 2 ? 0 : col + 1;

  if (matrix[row][col] != 0) {
    solve(matrix, nextRow, nextCol, solutions);
  } else {
    for (int i = 0; i <= matrix[row][matrix[0].length - 1]; i++) {
      matrix[row][col] = i;
      if (isValidPartial(matrix, row, col)) {
        solve(matrix, nextRow, nextCol, solutions);
      }
      matrix[row][col] = 0;
    }
  }
}

bool isValidPartial(List<List<int>> matrix, int row, int col) {
  int rowSum = 0;
  int colSum = 0;
  for (int i = 0; i < matrix.length - 1; i++) {
    rowSum += matrix[i][col];
    colSum += matrix[row][i];
  }

  if (rowSum > matrix[matrix.length - 1][col] || colSum > matrix[row][matrix[0].length - 1]) {
    return false;
  }
  return true;
}

bool isValidSolution(List<List<int>> matrix) {
  for (int row = 0; row < matrix.length - 1; row++) {
    int sum = matrix[row].sublist(0, matrix[row].length - 1).reduce((a, b) => a + b);
    if (sum != matrix[row].last) return false;
  }

  for (int col = 0; col < matrix[0].length - 1; col++) {
    int sum = 0;
    for (int row = 0; row < matrix.length - 1; row++) {
      sum += matrix[row][col];
    }
    if (sum != matrix[matrix.length - 1][col]) return false;
  }

  return true;
}

void printMatrix(List<List<int>> matrix) {
  for (var row in matrix) {
    print(row.join(' '));
  }
}

List<List<int>> cloneMatrix(List<List<int>> matrix) {
  return matrix.map((row) => List<int>.from(row)).toList();
}
