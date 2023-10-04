class Johnson {
  calcJon(List<List<String>> mat) {
    int n = mat.length;
    int sm = 0;
    List<String> rutaMasLarga = [];

    void vuelta(int pos, int sum, List<String> ruta) {
      ruta.add(mat[0][pos]);
      if (sum > sm) {
        sm = sum;
        rutaMasLarga = ruta.toList();
      }

      for (int i = 1; i < n; i++) {
        if (mat[pos][i] != "0") {
          vuelta(i, sum + int.parse(mat[pos][i]), List.from(ruta));
        }
      }
    }

    for (int i = 1; i < n; i++) {
      vuelta(i, 0, []);
    }
    return [rutaMasLarga, sm];
  }

  mays(List<List<String>> mat) {
    List<List<int>> lt = [];
    List<int> lc;
    List<int> sum = [0];
    for (int i = 1; i < mat.length; i++) {
      lc = [];
      for (int j = 1; j < mat.length; j++) {
        if (mat[j][i] != "0") {
          lc.add(j);
        }
      }
      lt.add(lc);
    }
    //print(lt);
    for (int i = 0; i < lt.length; i++) {
      int k = 0;
      if (lt[i].length > 1) {
        for (int j = 0; j < lt[i].length; j++) {
          if (sum[lt[i][j] - 1] + int.parse(mat[lt[i][j]][i + 1]) > k) {
            k = sum[lt[i][j] - 1] + int.parse(mat[lt[i][j]][i + 1]);
          }
        }
        sum.add(k);
      } else if (lt[i].length == 1) {
        k = sum[lt[i][0] - 1] + int.parse(mat[lt[i][0]][i + 1]);
        sum.add(k);
      }
    }

    return sum;
  }

  mins(List<List<String>> mat, int may) {
    int n = mat.length - 1;
    List<List<int>> lt = [];
    List<int> lc;
    List<int> sum = [may];

    for (int i = n; i > 0; i--) {
      lc = [];
      for (int j = n; j > 0; j--) {
        if (mat[i][j] != "0") {
          lc.add(j);
        }
      }
      lt.add(lc);
    }
    //print(lt);
    int k = may;
    for (int i = 0; i < lt.length; i++) {
      if (lt[i].length > 1) {
        for (int j = 0; j < lt[i].length; j++) {
          if (sum[lt.length - lt[i][j]] -
                  int.parse(mat[lt.length - i][lt[i][j]]) <
              k) {
            k = sum[lt.length - lt[i][j]] -
                int.parse(mat[lt.length - i][lt[i][j]]);
          }
        }
        sum.add(k);
      } else if (lt[i].length == 1) {
        k = sum[lt.length - lt[i][0]] - int.parse(mat[lt.length - i][lt[i][0]]);
        sum.add(k);
      }
    }

    sum = sum.reversed.toList();

    return sum;
  }

  sacaHolg(List<List<String>> mat, List<String> rutlar, int may, List<int> vals,
      List<int> valsn) {
    int n = mat.length - 1;
    int fin = mat[0].indexOf(rutlar[rutlar.length - 1]);
    List<List<String>> nmat =
        List.generate(n, (_) => List.generate(n, (_) => "-"));
    //List<int> nums = [];
    vuelta(pos, int sm) {
      if (esIni(mat, pos)) {
        return;
      }
      for (int i = n; i >= 1; i--) {
        if (mat[i][pos] != "0") {
          nmat[i - 1][pos - 1] =
              (sm - vals[i - 1] - int.parse(mat[i][pos])).toString();
          vuelta(i, valsn[i - 1]);
        }
      }
    }

    vuelta(fin, may);

    return nmat;
  }

  bool esIni(List<List<String>> mat, int col) {
    for (int i = 1; i < mat.length; i++) {
      if (mat[i][col] != "0") {
        return false;
      }
    }
    return true;
  }
}
