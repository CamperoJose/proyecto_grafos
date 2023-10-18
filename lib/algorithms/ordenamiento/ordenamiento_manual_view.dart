import 'dart:math';
import 'package:flutter/material.dart';
import 'package:proyecto_grafos/algorithms/ordenamiento/algoritmos/insert_sort.dart';
import 'package:proyecto_grafos/algorithms/ordenamiento/algoritmos/merge_sort.dart';
import 'package:proyecto_grafos/algorithms/ordenamiento/algoritmos/shell_sort.dart';
import 'package:proyecto_grafos/algorithms/ordenamiento/simulaciones/simulation_insertion_view.dart';
import 'package:proyecto_grafos/algorithms/ordenamiento/simulaciones/simulation_merge_sort.dart';
import 'package:proyecto_grafos/algorithms/ordenamiento/simulaciones/simulation_shell_view.dart';
import 'algoritmos/bubble_sort.dart';
import 'simulaciones/simulation_bubble_view.dart';

class OrdenamientoManualView extends StatefulWidget {
  @override
  _OrdenamientoManualViewState createState() => _OrdenamientoManualViewState();
}

class _OrdenamientoManualViewState extends State<OrdenamientoManualView> {
  final TextEditingController _numberController = TextEditingController();
  List<int> listNumbers = [];
  List<int> sortedRandomNumbers = [];
  Duration sortingTime = Duration();

  void generateRandomNumbers(int count) {
    final random = Random();
    listNumbers.clear();
    for (int i = 0; i < count; i++) {
      listNumbers.add(random.nextInt(100));
    }
    setState(() {
      sortedRandomNumbers = [];
      sortingTime = Duration();
    });
  }

  void sortNumbersWithBubbleSort() {
    final List<int> numbers = List.from(listNumbers);
    final DateTime startTime = DateTime.now();
    final List<int> sortedNumbers = bubbleSort(numbers);
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);

    setState(() {
      listNumbers = numbers;
      sortedRandomNumbers = sortedNumbers;
      sortingTime = duration;
    });
  }

  void sortNumbersWithInsertionSort() {
    final List<int> numbers = List.from(listNumbers);
    final DateTime startTime = DateTime.now();
    final List<int> sortedNumbers = insertionSort(numbers);
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);

    setState(() {
      listNumbers = numbers;
      sortedRandomNumbers = sortedNumbers;
      sortingTime = duration;
    });
  }

  void sortNumbersWithMergeSort() {
    final List<int> numbers = List.from(listNumbers);
    final DateTime startTime = DateTime.now();
    final List<int> sortedNumbers = mergeSort(numbers);
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);

    setState(() {
      listNumbers = numbers;
      sortedRandomNumbers = sortedNumbers;
      sortingTime = duration;
    });
  }

  void sortNumbersWithShellSort() {
    final List<int> numbers = List.from(listNumbers);
    final DateTime startTime = DateTime.now();
    final List<int> sortedNumbers = shellSort(numbers);
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);

    setState(() {
      listNumbers = numbers;
      sortedRandomNumbers = sortedNumbers;
      sortingTime = duration;
    });
  }

  Widget buildGridButton(
      Color color, IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ordenamiento de Números (Input Manual)'),
          backgroundColor: Colors.deepPurple.shade900,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Agregue números a la lista',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: TextField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        //verificar si es un valor entero, si es una letra no se agrega y se muestra una alerta:
                        


                        setState(() {
                          final int? number =
                              int.tryParse(_numberController.text);
                          if (number != null) {
                            listNumbers.add(number);
                          }
                          _numberController.clear();
                        });
                      },
                      child: Text('Agregar a la lista'),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 52, 58, 145),
                      ),
                    ),
                  ],
                ),
                if (listNumbers.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  SizedBox(width: 20),
                  Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      "Números: ${listNumbers.join(", ")}",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 20),
    ElevatedButton(
      onPressed: () {
        setState(() {
          listNumbers.clear();
        });
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 184, 71, 63),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cleaning_services,
            size: 18,
          ),
          SizedBox(width: 10),
          Text(
            "Limpiar",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    ),
  ],
)

                ],
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  shrinkWrap: true,
                  children: [
                    buildGridButton(Colors.orange, Icons.sort, 'Bubble Sort',
                        () {
                      sortNumbersWithBubbleSort();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Text('Números ordenados (Bubble Sort)'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(sortedRandomNumbers.join(", ")),
                                SizedBox(height: 10),
                                Text(
                                    'Tiempo de ordenamiento: ${sortingTime} ms'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cerrar',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 163, 45, 37),
                                        fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SimulationView(
                                        originalNumbers: listNumbers,
                                        sortedNumbers: sortedRandomNumbers,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Ver Simulación'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 52, 145, 55),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                    buildGridButton(const Color.fromARGB(255, 41, 119, 157),
                        Icons.sort, 'Insertion Sort', () {
                      sortNumbersWithInsertionSort();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                'Números ordenados (Insertion Sort)'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(sortedRandomNumbers.join(", ")),
                                SizedBox(height: 10),
                                Text(
                                    'Tiempo de ordenamiento: ${sortingTime} ms'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cerrar',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 163, 45, 37),
                                        fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SimulationViewInsertion(
                                        originalNumbers: listNumbers,
                                        sortedNumbers: sortedRandomNumbers,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Ver Simulación'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 52, 145, 55),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                    buildGridButton(Color.fromARGB(255, 214, 49, 156),
                        Icons.sort, 'Merge Sort', () {
                      sortNumbersWithInsertionSort();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Números ordenados (Merge Sort)'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(sortedRandomNumbers.join(", ")),
                                SizedBox(height: 10),
                                Text('Tiempo de ordenamiento: ${sortingTime} '),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cerrar',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 163, 45, 37),
                                        fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SimulationViewMerge(
                                        originalNumbers: listNumbers,
                                        sortedNumbers: sortedRandomNumbers,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Ver Simulación'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 52, 145, 55),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                    buildGridButton(Color.fromARGB(255, 65, 136, 30),
                        Icons.sort, 'Shell Sort', () {
                      sortNumbersWithShellSort();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Números ordenados (Shell Sort)'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(sortedRandomNumbers.join(", ")),
                                SizedBox(height: 10),
                                Text(
                                    'Tiempo de ordenamiento: ${sortingTime} ms'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cerrar',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 163, 45, 37),
                                        fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SimulationViewShell(
                                        originalNumbers: listNumbers,
                                        sortedNumbers: sortedRandomNumbers,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Ver Simulación'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 52, 145, 55),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
