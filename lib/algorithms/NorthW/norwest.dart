import 'dart:math';

class Norwest {
  calcNor(List<List<String>> mat, List<String> disp, List<String> dem,
      {bool alfa = false, int? valmen, List<int>? posval}) {
    int s = 0;
    List<int> esq = [0, 0];
    List<List<String>> teta =
    List.generate(disp.length, (_) => List.filled(dem.length, ""));
    List<String> dispaux = disp.toList();
    List<String> demaux = dem.toList();

    while (esq[0] <= disp.length && esq[1] <= dem.length) {
      int valdisp = int.parse(dispaux[esq[0]]);
      int valdem = int.parse(demaux[esq[1]-1]);
      if (valdem == valdisp) {
        teta[esq[0]][esq[1]] = valdisp.toString();
        valdisp = 0;
        valdem = 0;
        dispaux[esq[0]] = valdisp.toString();
        demaux[esq[1]] = valdem.toString();
        esq[1]++;
        esq[0]++;
      } else if (valdisp > valdem) {
        teta[esq[0]][esq[1]] = valdem.toString();
        valdisp -= valdem;
        valdem = 0;
        dispaux[esq[0]] = valdisp.toString();
        demaux[esq[1]] = valdem.toString();
        esq[1]++;
      } else if (valdisp < valdem) {
        teta[esq[0]][esq[1]] = valdisp.toString();
        valdem -= valdisp;
        valdisp = 0;
        dispaux[esq[0]] = valdisp.toString();
        demaux[esq[1]] = valdem.toString();
        esq[0]++;
      }
    }
    if (alfa) {
      teta[posval![0]][posval[1]] = "x";
      //print(sacaAlfa(teta));
      teta = cambioTeta(teta, posval[0], posval[1]);
      teta = nuevoTeta(teta, sacaAlfa(teta));
    }
    print(teta);

    for (int i = 0; i < teta.length; i++) {
      for (int j = 0; j < teta[0].length; j++) {
        if (teta[i][j].isNotEmpty) {
          s += int.parse(teta[i][j]) * int.parse(mat[i + 1][j + 1]);
        }
      }
    }

    List<List<String>> cj =
    List.generate(disp.length, (_) => List.filled(dem.length, ""));

    for (int i = 0; i < disp.length; i++) {
      for (int j = 0; j < dem.length; j++) {
        if (teta[i][j] != "" && teta[i][j] != "x") {
          cj[i][j] = mat[i + 1][j + 1];
        }
      }
    }
    if (alfa) {
      for (int i = 0; i < cj.length; i++) {
        for (int j = 0; j < cj[0].length; j++) {
          if (cj[i][j].isNotEmpty) {
            if (teta[i][j] == "0") {
              cj[i][j] = "";
            }

            //s += int.parse(teta[i][j]) * int.parse(mat[i + 1][j + 1]);
          }
        }
      }
    }

    //print(cj);
    //print(mat);
    cj = nuevoCj(cj, getDemands(cj));

    List<List<String>> zjcj = [];
    zjcj = restazjcj(mat, cj);
    //sacaMenMat(zjcj);

    var men = sacaMenMat(zjcj);
    print(s);
    if (men[0] < 0 && alfa == false) {
      return calcNor(mat, disp, dem,
          alfa: true, valmen: men[0], posval: men[1]);
    }

    return [s, zjcj];
  }

  List<List<String>> cambioTeta(List<List<String>> matriz, int posX, int posY) {
    List<List<String>> matrizEquiv = List.from(matriz);
    List<int> esq = [posX, posY];
    bool posi = true;
    if (cantFilCol(matriz, posX, posY)) {
      for (int i = 0; i < matrizEquiv.length; i++) {
        if (matrizEquiv[i][posY] != "" && matrizEquiv[i][posY] != "x") {
          matrizEquiv[i][posY] = matrizEquiv[i][posY] + "-x";
          esq[0] = matrizEquiv[i].indexOf(matrizEquiv[i][posY]);
          posi = false;
          break;
        }
      }
    } else {
      for (int i = 0; i < matrizEquiv[0].length; i++) {
        if (matrizEquiv[posX][i] != "" && matrizEquiv[posX][i] != "x") {
          matrizEquiv[posX][i] = matrizEquiv[posX][i] + "-x";
          esq[1] = matrizEquiv[0].indexOf(matrizEquiv[posX][i]);
          posi = false;
          break;
        }
      }
    }

    while (true) {
      if (matrizEquiv[esq[0]][esq[1]].isEmpty &&
          matrizEquiv[esq[0]][esq[1]] != "x") {
        esq[0]++;
        esq[1]--;
      } else {
        if (int.tryParse(matrizEquiv[esq[0]][esq[1]]) != null) {
          if (posi) {
            matrizEquiv[esq[0]][esq[1]] = matrizEquiv[esq[0]][esq[1]] + "-x";
            posi = !posi;
          } else {
            matrizEquiv[esq[0]][esq[1]] = matrizEquiv[esq[0]][esq[1]] + "+x";
            posi = !posi;
          }
        }
        esq[1]++;
      }
      if (esq[0] == posX) {
        if (posi) {
          matrizEquiv[esq[0]][esq[1]] = matrizEquiv[esq[0]][esq[1]] + "-x";
        } else {
          matrizEquiv[esq[0]][esq[1]] = matrizEquiv[esq[0]][esq[1]] + "+x";
        }
        break;
      }
    }

    return matrizEquiv;
  }

  bool cantFilCol(List<List<String>> matriz, int posX, int posY) {
    int cf = 0;
    int cc = 0;
    for (int i = 0; i < matriz[0].length; i++) {
      if (matriz[posX][i] != "" && matriz[posX][i] != "x") {
        cf++;
      }
    }
    for (int i = 0; i < matriz.length; i++) {
      if (matriz[i][posY] != "" && matriz[posX][i] != "x") {
        cc++;
      }
    }
    if (cc <= cf) {
      return true;
    }
    return false;
  }

  List<List<String>> nuevoTeta(List<List<String>> matr, int alf) {
    List<List<String>> nmat = List.from(matr);
    int sum = -1;
    int res = -1;
    for (int i = 0; i < matr.length; i++) {
      sum = -1;
      res = -1;
      for (int j = 0; j < matr[0].length; j++) {
        if (matr[i][j] == 'x') {
          matr[i][j] = alf.toString();
        }
        if (matr[i][j].isNotEmpty) {
          if (int.tryParse(matr[i][j]) == null) {
            sum = matr[i][j].indexOf('+');
            res = matr[i][j].indexOf('-');
            if (sum > -1 || res > -1) {
              if (sum > res) {
                matr[i][j] =
                    (int.parse(matr[i][j].substring(0, sum)) + alf).toString();
              } else {
                matr[i][j] =
                    (int.parse(matr[i][j].substring(0, res)) - alf).toString();
              }
            }
          }
        }
      }
    }
    return nmat;
  }

  int sacaAlfa(List<List<String>> matr) {
    int a = 100000000;
    int sum = -1;
    int res = -1;
    int pos = -1;
    for (int i = 0; i < matr.length; i++) {
      pos = -1;
      sum = -1;
      res = -1;
      for (int j = 0; j < matr[0].length; j++) {
        if (matr[i][j].isNotEmpty && matr[i][j] != "x") {
          if (int.tryParse(matr[i][j]) == null) {
            sum = matr[i][j].indexOf('+');
            res = matr[i][j].indexOf('-');
            if (sum > -1 || res > -1) {
              pos = sum > res ? sum : res;
              if (int.parse(matr[i][j].substring(0, pos)) < a) {
                a = int.parse(matr[i][j].substring(0, pos));
              }
            }
          }
        }
      }
    }

    return a;
  }

  List<List<String>> restazjcj(List<List<String>> zj, List<List<String>> cj) {
    int f = cj.length;
    int c = cj[0].length;
    List<List<String>> zjcj = List.generate(f, (_) => List.filled(c, ""));
    for (int i = 0; i < f; i++) {
      for (int j = 0; j < c; j++) {
        zjcj[i][j] =
            (int.parse(zj[i + 1][j + 1]) - int.parse(cj[i][j])).toString();
      }
    }
    return zjcj;
  }

  List<List<String>> nuevoCj(
      List<List<String>> matr, List<List<String>> ndemdis) {
    for (int i = 0; i < matr.length; i++) {
      for (int j = 0; j < matr[0].length; j++) {
        if (matr[i][j] == "") {
          matr[i][j] =
              (int.parse(ndemdis[0][i]) + int.parse(ndemdis[1][j])).toString();
        }
      }
    }
    return matr;
  }

  List<List<String>> getDemands(List<List<String>> matrix) {
    int f = matrix.length;
    int c = matrix[0].length;
    List<String> ndisp = List.filled(f, "0");
    List<String> ndem = List.filled(c, "0");
    List<int> esq = [0, 0];
    bool dispo = true;

    while (esq[0] < f && esq[1] < c) {
      if (dispo) {
        if (esq[0] < f && esq[1] < c && matrix[esq[0]][esq[1]] != "") {
          if (esq[0] == 0) {
            ndisp[0] = sacaMenFil(matrix, 0).toString();
          }
          ndem[esq[1]] =
              (int.parse(matrix[esq[0]][esq[1]]) - int.parse(ndisp[esq[0]]))
                  .toString();
          esq[1]++;
          dispo = !dispo;
        } else {
          esq[1]++;
        }
      } else {
        if (esq[0] < f && esq[1] < c && matrix[esq[0]][esq[1]] != "") {
          ndem[esq[1]] =
              (int.parse(matrix[esq[0]][esq[1]]) - int.parse(ndisp[esq[0]]))
                  .toString();
          esq[0]++;
          if (esq[0] < f) {
            ndisp[esq[0]] =
                (int.parse(matrix[esq[0]][esq[1]]) - int.parse(ndem[esq[1]]))
                    .toString();
          }
          dispo = !dispo;
        } else {
          esq[0]++;
          if (esq[0] == f - 1 && esq[1] == c - 1) {
            break;
          }
        }
      }
    }
    //print(ndisp);
    //print(ndem);
    return [ndisp, ndem];
  }

  int sacaMenFil(List<List<String>> matrix, int fila) {
    int mn = matrix[fila]
        .where((element) => element.isNotEmpty)
        .map(int.parse)
        .reduce(min);
    return mn;
  }

  List<dynamic> sacaMenMat(List<List<String>> matrix) {
    int mn = 0;
    List<int> pos = [-1, -1];
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[0].length; j++) {
        if (int.parse(matrix[i][j]) < mn) {
          mn = int.parse(matrix[i][j]);
          pos = [i, j];
        }
      }
    }

    return [mn, pos];
  }
}
