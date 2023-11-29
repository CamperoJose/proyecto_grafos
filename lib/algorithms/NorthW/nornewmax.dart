import 'dart:math';

class NorwestMax {
  ResultadoMax calcNorwestMax(List<List<int>> matrizOriginal, List<int> disponibilidad, List<int> demanda,
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
        menor=men[0];
        posiciones=men[1];
        menorResultado=sacaMenorPositivo(matrizResultado);
        print('MEN $men');
        nuevaMatriz=nuevaMatrizResultado(matrizResultado,menor,menorResultado,posiciones);
        print('Nueva Matriz $nuevaMatriz');
        contadoriteracion++;
        if(contadoriteracion==2)
          {
            sumatoria=0;
          for (int i = 0; i < nuevaMatriz.length; i++) {
            for (int j = 0; j < nuevaMatriz[0].length; j++) {

              if(nuevaMatriz[i][j]<0)
              {
                sumatoria -= nuevaMatriz[i][j] * matrizOriginal[i ][j ];
              }
              else{
                sumatoria += nuevaMatriz[i][j] * matrizOriginal[i ][j ];
              }
            }
          }
          bucle=false;
          }
    }
    return ResultadoMax(nuevaMatriz, sumatoria);
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
    int mn = -1;
    List<int> pos = [-1, -1];
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[0].length; j++) {
        if (matrix[i][j] > mn) {
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

  List<List<int>> nuevaMatrizResultado(List<List<int>> matrix, int menor, int menorX, List<int> posiciones) {
    int fila = posiciones[0];
    int columna = posiciones[1];
    int  contador = 1, pos = 1;
    bool alternarPN = true, primerDigito = true, dig0 = true, nuevoX = true,cambio=true,entro=true,primeraAsignacion=true,primeravez=true,asignacionFicticia=true;

    List<int> posFila = [];
    List<int> posCol = [];
    List<int> posFilaG = [];
    List<int> posColG = [];

    // Obtener la dirección actual
    menorX = 0;
    while (nuevoX) {
      // Mientras estemos dentro de los límites de la matriz y la casilla no sea 0
      while (fila != posiciones[0] || columna != posiciones[1]|| entro) {
        entro= !entro;
        print('Iteracion $contador');
        contador++;
        if (primerDigito == false && fila == posiciones[0] && columna == posiciones[1]) {
          if (menorX == 0) {
            menorX = encontrarMenorValorEnPosiciones(matrix, posFila, posCol);
            print('Menor x $menorX');
            primerDigito = !primerDigito;
            posFila.clear();
            posCol.clear();
            posFilaG.clear();
            posColG.clear();
            alternarPN = true; primerDigito = true; dig0 = false; nuevoX = true;cambio=true;entro=true;asignacionFicticia=false;primeravez=true;
          } else {
            nuevoX = false;
          }
        } else if (primerDigito) {
          if(primeraAsignacion){
            fila = posiciones[0];
            columna = posiciones[1];
            matrix[fila][columna] = 500;
            posFilaG.add(fila); posColG.add(columna);
            print('FilaPrimerDigito$fila');
            print('ColumnaPrimerDigito$columna');
            print('Primer Digito');
            pos++;
            primerDigito = !primerDigito;
            primeraAsignacion= !primeraAsignacion;
          }else {
            fila = posiciones[0];
            columna = posiciones[1];
            matrix[fila][columna] = menorX;
            posFilaG.add(fila);
            posColG.add(columna);
            print('FilaPrimerDigito$fila');
            print('ColumnaPrimerDigito$columna');
            print('Primer Digito');
            pos++;
            primerDigito = !primerDigito;
          }
        } else {
          if (alternarPN ) {
            matrix[fila][columna] -= menorX;
            posFila.add(fila); posCol.add(columna);
            posFilaG.add(fila); posColG.add(columna);
            print('Negativo');
            pos++;
            alternarPN = !alternarPN;
            if(primeraAsignacion==false)
              primeravez=false;
          } else if (alternarPN == false ) {
            matrix[fila][columna] += menorX;
            alternarPN = !alternarPN;
            posFilaG.add(fila); posColG.add(columna);
            print('Positivo');
          }
        }
        print('Matriz  $matrix');
        int numFila = fila;
        int numColumna = columna;
        while (cambio) {
          int filaActual = fila;
          int columnaActual = columna;

          if (dig0) {
            // Buscar en la fila actual
            numColumna = buscarNumeroCercanoEnFila(matrix, filaActual, columnaActual,primeravez,menorX,posiciones,asignacionFicticia);
            if (numColumna != -1) {
              // Se encontró un número diferente de 0 en la fila, salir del bucle
              columna = numColumna;
              cambio = false;
            }
            print('Columna $numColumna');
            // Actualizar la posición actual y agregarla a las listas
            posFilaG.add(numFila);
            posColG.add(numColumna);
            dig0 = !dig0;
          } else {
            // Buscar en la columna del número encontrado en la fila
            print('Columna antes de F $numColumna');
            numFila = buscarNumeroCercanoEnColumna(matrix, numColumna, numFila,primeravez,menorX,posiciones,asignacionFicticia);
            if (numFila != -1) {
              // Se encontró un número diferente de 0 en la columna, salir del bucle
              fila=numFila;
              cambio = false;
            }
            print('Fila $numFila');
            posFilaG.add(numFila);
            posColG.add(numColumna);
            dig0 = !dig0;
          }

        }
        cambio = !cambio;
      }

    }

    return matrix;
  }
  int buscarNumeroCercanoEnFila(List<List<int>> matrix, int fila, int columna,bool primeravez,int menorX,List<int>posiciones,bool CasigFic) {
    int posicionInicial = columna;
    List<int> filaActual = matrix[fila];
    bool verificacion1=primeravez;
    int esfila=1;

    int menX=menorX;
    return encontrarPosicionNumeroMasCercano(filaActual, posicionInicial,verificacion1,menX,matrix,posiciones,CasigFic,esfila);
  }

  int buscarNumeroCercanoEnColumna(List<List<int>> matrix, int columna, int fila,bool primeravez,int menorX,List<int>posiciones,bool CasigFic) {
    int posicionInicial = fila;
    List<int> columnaActual =[];
    bool verificacion1=primeravez;
    int menX=menorX;
    List<List<int>> matriz=matrix;
    for (int j = 0; j < matrix.length; j++) {
      columnaActual.add(matrix[j][columna]);
    }
    int esCol=2;
    return encontrarPosicionNumeroMasCercano(columnaActual, posicionInicial,verificacion1,menX,matrix,posiciones,CasigFic,esCol);
  }

  int encontrarPosicionNumeroMasCercano(List<int> lista, int posicionInicial, bool primeravez, int menorX, List<List<int>> matrix, List<int> posicionIni,bool asigFic,int FilCol) {
    print('Verificacion $primeravez');
    print('Verificacion FICTICIA $asigFic');
    print('Lista $lista');


    if (primeravez == false) {
      int filaPosIni = posicionIni[0];
      int columnaPosIni = posicionIni[1];

      if(asigFic){
        if (lista.contains(500)) {
          // Verificar si menorX pertenece a la fila correspondiente
          if (matrix[filaPosIni].contains(500)) {
            // Comparar si menorX es igual al valor en la posición inicial
            if (matrix[filaPosIni][columnaPosIni] == 500) {
              return filaPosIni;
            }
          }
          // Verificar si menorX pertenece a la columna correspondiente
          else if (matrix.map((fila) => fila[columnaPosIni]).toList().contains(500)) {
            // Comparar si menorX es igual al valor en la posición inicial
            if (matrix[filaPosIni][columnaPosIni] == 500) {
              return columnaPosIni;
            }
          }
        }

      }else{
        if (lista.contains(menorX)) {
          // Verificar si menorX pertenece a la fila correspondiente
          if (matrix[filaPosIni].contains(menorX)&&FilCol==1) {
            // Comparar si menorX es igual al valor en la posición inicial
            if (matrix[filaPosIni][columnaPosIni] == menorX) {
              return columnaPosIni;
            }
          }
          else  {
            // Comparar si menorX es igual al valor en la posición inicial
            for (int j = 0; j < matrix.length; j++) {
              if (j==filaPosIni) {
                return filaPosIni;
              }
            }
          }
        }
      }
    }

    int posicionMasCercana = 0;
    int distanciaMinima = -1;

    for (int i = 0; i < lista.length; i++) {
      if (lista[i] != 0 && i != posicionInicial) {
        int distanciaActual = (i - posicionInicial).abs();
        if (distanciaMinima == -1 || distanciaActual < distanciaMinima && i != posicionInicial) {
          distanciaMinima = distanciaActual;
          posicionMasCercana = i;
        }
      }
    }
    return posicionMasCercana;
  }
  int encontrarMenorValorEnPosiciones(List<List<int>> matrix, List<int> posFila, List<int> posCol) {
    if (posFila.length != posCol.length || posFila.isEmpty || posCol.isEmpty) {
      // Las listas de posiciones deben tener la misma longitud y no estar vacías
      throw ArgumentError("Las listas de posiciones no son válidas");
    }

    int menorValor = matrix[posFila[0]][posCol[0]]; // Inicializar con el primer valor

    for (int i = 1; i < posFila.length; i++) {
      int valorActual = matrix[posFila[i]][posCol[i]];
      if (valorActual < menorValor) {
        menorValor = valorActual;
      }
    }

    return menorValor;
  }

  int sacaMenorPositivo(List<List<int>> matrix) {
    int mn = -1;
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[0].length; j++) {
        if (matrix[i][j] > mn&&matrix[i][j]!=0) {
          mn = (matrix[i][j]);
        }
      }
    }
    return mn;
  }

}

class ResultadoMax {
  List<List<int>> matriz;
  int sumatoria;

  ResultadoMax(this.matriz, this.sumatoria);
}


