import 'dart:math';

class Norwest {
  ResultadoNorwest calcNorwest(List<List<int>> matrizOriginal, List<int> disponibilidad, List<int> demanda,
      {bool iteracion = false, int? valmen, List<int>? posval}) {
    int sumatoria = 0;
    bool bucle=true;
    List<int> controladorEsquina = [0, 0]; //esq
    List<List<int>> matrizResultado = List.generate(disponibilidad.length, (_) => List.filled(demanda.length,0)); //Asignar tama;o de la matriz original/ cambiar valores
    List<int> dispoaux = disponibilidad.toList();
    List<int> demanux = demanda.toList();
    List<List<int>> nuevaMatriz = [];


    while (controladorEsquina[0] < disponibilidad.length && controladorEsquina[1] < demanda.length) {
      int valorDisponibilidad = dispoaux[controladorEsquina[0]];
      int valorDemanda = demanux[controladorEsquina[1]];

      // Si Demanda = Oferta
      if (valorDemanda == valorDisponibilidad) {
        matrizResultado[controladorEsquina[0]][controladorEsquina[1]] = valorDisponibilidad;
        valorDisponibilidad = 0;
        valorDemanda = 0;
        dispoaux[controladorEsquina[0]] = valorDisponibilidad;
        demanux[controladorEsquina[1]] = valorDemanda;
        controladorEsquina[0]++;
        controladorEsquina[1]++;
      }
      // Si OFerta> Demanda
      else if (valorDisponibilidad > valorDemanda) {
        matrizResultado[controladorEsquina[0]][controladorEsquina[1]] = valorDemanda;
        valorDisponibilidad -= valorDemanda;
        valorDemanda = 0;
        dispoaux[controladorEsquina[0]] = valorDisponibilidad;
        demanux[controladorEsquina[1]] = valorDemanda;
        controladorEsquina[1]++;
      }

      //Si demanda > oferta
      else if (valorDisponibilidad < valorDemanda) {
        matrizResultado[controladorEsquina[0]][controladorEsquina[1]] = valorDisponibilidad;
        valorDemanda -= valorDisponibilidad;
        valorDisponibilidad = 0;
        dispoaux[controladorEsquina[0]] = valorDisponibilidad;
        demanux[controladorEsquina[1]] = valorDemanda;
        controladorEsquina[0]++;
      }
    }
    while(bucle){
      sumatoria=0;
    for (int i = 0; i < matrizResultado.length; i++) {
      for (int j = 0; j < matrizResultado[0].length; j++) {
        
          sumatoria += matrizResultado[i][j] * matrizOriginal[i ][j ];

      }
    }

    List<List<int>> cj = List.generate(disponibilidad.length, (_) => List.filled(demanda.length, 0));

    for (int i = 0; i < disponibilidad.length; i++) {
      for (int j = 0; j < demanda.length; j++) {
        if (matrizResultado[i][j] != 0 && matrizResultado[i][j] != -100) {
          cj[i][j] = matrizOriginal[i][j];

        }
      }
    }
    if (iteracion) {
      for (int i = 0; i < cj.length; i++) {
        for (int j = 0; j < cj[0].length; j++) {
          if (cj[i][j]>0) {
            if (matrizResultado[i][j] == 0) {
              cj[i][j] = 0;
            }
          }
        }
      }
    }
    cj = nuevoCj(cj, getDemands(cj));

    List<List<int>> zjcj = [];
    zjcj = restazjcj(matrizOriginal, cj);
    print('Nuevo Cj $zjcj');

    var men = sacaMenMat(zjcj);
    int contadoriteracion=1;
    int menor=0;
    int menorResultado=0;
    List<int> posiciones=[];

    if (men[0] < 0 ) {
      menor=men[0];
      posiciones=men[1];
      menorResultado=sacaMenorPositivo(matrizResultado);
      print('MEN $men');
      nuevaMatriz=nuevaMatrizResultado(matrizResultado,menor,menorResultado,posiciones);
      print('Nueva Matriz $nuevaMatriz');
    contadoriteracion++;
    }else{
      bucle=false;
    }
    }
    return ResultadoNorwest(nuevaMatriz, sumatoria);
  }
  List<List<int>> nuevoCj(List<List<int>> matr, List<List<int>> ndemdis) {
    for (int i = 0; i < matr.length; i++) {
      for (int j = 0; j < matr[0].length; j++) {
        if (matr[i][j] == 0) {
          matr[i][j] = (ndemdis[0][i] + ndemdis[1][j]);
        }
      }
    }
    return matr;
  }
  List<List<int>> restazjcj(List<List<int>> zj, List<List<int>> cj) {
    int f = cj.length;
    int c = cj[0].length;
    List<List<int>> zjcj = List.generate(f, (_) => List.filled(c, 0));
    for (int i = 0; i < f; i++) {
      for (int j = 0; j < c; j++) {
        zjcj[i][j] = (zj[i][j] - cj[i][j]);
      }
    }
    return zjcj;
  }
  List<dynamic> sacaMenMat(List<List<int>> matrix) {
    int mn = 0;
    List<int> pos = [-1, -1];
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[0].length; j++) {
        if (matrix[i][j] < mn) {
          mn = (matrix[i][j]);
          pos = [i, j];
        }
      }
    }
    return [mn, pos];
  }
  List<List<int>> getDemands(List<List<int>> matrix) {
    int f = matrix.length;
    int c = matrix[0].length;
    List<int> ndisp = List.filled(f, 0);
    List<int> ndem = List.filled(c, 0);
    List<int> esq = [0, 0];
    bool alternarCF = true;

    while (esq[0] < f && esq[1] < c) {
      if (alternarCF) {
        if (esq[0] < f && esq[1] < c && matrix[esq[0]][esq[1]] != 0){
          if(ndisp[esq[0]]!=0)
            {
              ndem[esq[1]]=matrix[esq[0]][esq[1]]-ndisp[esq[0]];
            }else if(ndisp[esq[0]]==matrix[esq[0]][esq[1]]){
               ndem[esq[1]]=0;
                }else{
                 ndem[esq[1]]=(matrix[esq[0]][esq[1]])-1;
                 if(ndem[esq[1]]<=0)
                 {
                  ndem[esq[1]] = matrix[esq[0]][esq[1]];
                 }
                }
          if(ndisp[esq[0]]+ndem[esq[1]]==matrix[esq[0]][esq[1]]){
            esq[0]++;
          }
          alternarCF = !alternarCF;
        }else{
          esq[1]++;
        }
      } else {
        if (esq[0] < f && esq[1] < c && matrix[esq[0]][esq[1]] != 0) {
          if(ndem[esq[1]]!=0)
          {
            ndisp[esq[1]]=matrix[esq[0]][esq[1]]-ndem[esq[0]];
          }
          else if(ndem[esq[1]]<matrix[esq[0]][esq[1]])
            {
              ndisp[esq[0]] = (matrix[esq[0]][esq[1]]-ndem[esq[1]]);
            }
          if(ndisp[esq[0]]+ndem[esq[1]]==matrix[esq[0]][esq[1]])
          {
            esq[1]++;
          }
          alternarCF = !alternarCF;
        } else {
          esq[0]++;
        }
      }
    }
    print(ndisp);
    print(ndem);
    return [ndisp, ndem];
  }

  List<List<int>> nuevaMatrizResultado(List<List<int>> matrix,int menor,int menorX,List<int>posiciones){
    int fila = posiciones[0];
    int columna = posiciones[1];
    int i=0;
    bool alternarPN= true,primerDigito= true,camino=true;
    List<List<int>> direcciones = [
      [0, 1],  // Derecha
      [-1, 0], // Arriba
      [0, -1], // Izquierda
      [1, 0],  // Abajo
    ];
    // Obtener la dirección actual
    int dirFila = direcciones[0][0];
    int dirColumna = direcciones[0][1];

      // Mientras estemos dentro de los límites de la matriz y la casilla no sea 0
      while (fila <= matrix.length  && columna <= matrix[0].length) {
        if(primerDigito==false&& fila==posiciones[0]&&columna==posiciones[1])
          {
            return matrix;
          }
        else if (primerDigito) {
          matrix[fila][columna] = menorX;

          primerDigito = !primerDigito;
        } else {
          // Restar o sumar x según corresponda
          if (alternarPN) {
            matrix[fila][columna] -= menorX;
            alternarPN = !alternarPN;
          } else {
            matrix[fila][columna] += menorX;
            alternarPN = !alternarPN;
          }
        }
        while(camino){
          if(dirFila >= 0 && dirFila > matrix.length &&
              dirColumna >= 0 && dirColumna > matrix[0].length
              && matrix[fila][columna] != 0){
                i++;
                dirFila = direcciones[i][0];
                dirColumna = direcciones[i][1];
          }else{
            camino = !camino;
            dirFila = direcciones[i][0];
            dirColumna = direcciones[i][1];
            i++;
            // Mover a la siguiente casilla en la dirección actual
            fila += dirFila;
            columna += dirColumna;
          }
        }
        camino = !camino;
      }
    return matrix;
  }
  int sacaMenorPositivo(List<List<int>> matrix) {
    int mn = 100;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[0].length; j++) {
        if (matrix[i][j] < mn&&matrix[i][j]!=0) {
          mn = (matrix[i][j]);
        }
      }
    }
    return mn;
  }

}

class ResultadoNorwest {
  List<List<int>> matriz;
  int sumatoria;

  ResultadoNorwest(this.matriz, this.sumatoria);
}


