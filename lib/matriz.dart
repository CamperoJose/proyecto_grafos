import 'classes/modelo_arista.dart';
import 'classes/modelo_nodo.dart';

List<ModeloNodo> vNodo = [];
List<ModeloArista> vUniones = [];
List<ModeloArista> vUnionesy = [];

//inizializando un vector de strings vacios:
List<String> values = [];

//inizializando una matriz de ints  con valores (1,2), (2,2):
// List<List<int>> matriz = [
//   [1, 2],
//   [2, 2]
// ];

List<List<int>> matrixTrueFalse = [];

List<List<int>> matrixArists = [];

//para jhonson:
List<List<int>> matrizHolguras = [];

List<String> longestPath = [];

List<List<String>> aux = []; // Lista de puentes a pintar en kruskal;
int sumaKruskal = 0;
int opKruskal = -1;
