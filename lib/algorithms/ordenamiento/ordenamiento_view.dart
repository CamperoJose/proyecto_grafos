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

class OrdenamientoView extends StatefulWidget {
  @override
  _OrdenamientoViewState createState() => _OrdenamientoViewState();
}

class _OrdenamientoViewState extends State<OrdenamientoView> {
  final TextEditingController _numberController = TextEditingController();
  List<int> randomNumbers = [];
  List<int> sortedRandomNumbers = [];
  Duration sortingTime = Duration();

  void generateRandomNumbers(int count) {
    final random = Random();
    randomNumbers.clear();
    for (int i = 0; i < count; i++) {
      randomNumbers.add(random.nextInt(100));
    }
    setState(() {
      sortedRandomNumbers = [];
      sortingTime = Duration();
    });
  }

  void sortNumbersWithBubbleSort() {
    final List<int> numbers = List.from(randomNumbers);
    final DateTime startTime = DateTime.now();
    final List<int> sortedNumbers = bubbleSort(numbers);
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);

    setState(() {
      randomNumbers = numbers;
      sortedRandomNumbers = sortedNumbers;
      sortingTime = duration;
    });
  }

    void sortNumbersWithInsertionSort() {
    final List<int> numbers = List.from(randomNumbers);
    final DateTime startTime = DateTime.now();
    final List<int> sortedNumbers = insertionSort(numbers);
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);

    setState(() {
      randomNumbers = numbers;
      sortedRandomNumbers = sortedNumbers;
      sortingTime = duration;
    });
  }

    void sortNumbersWithMergeSort() {
    final List<int> numbers = List.from(randomNumbers);
    final DateTime startTime = DateTime.now();
    final List<int> sortedNumbers = mergeSort(numbers);
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);

    setState(() {
      randomNumbers = numbers;
      sortedRandomNumbers = sortedNumbers;
      sortingTime = duration;
    });
  }

      void sortNumbersWithShellSort() {
    final List<int> numbers = List.from(randomNumbers);
    final DateTime startTime = DateTime.now();
    final List<int> sortedNumbers = shellSort(numbers);
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);

    setState(() {
      randomNumbers = numbers;
      sortedRandomNumbers = sortedNumbers;
      sortingTime = duration;
    });
  }

  Widget buildGridButton(Color color, IconData icon, String label, VoidCallback onPressed) {
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
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100), ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ordenamiento de Números'),
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
                const Text('Ingrese la cantidad de números a generar:', style: TextStyle(fontWeight: FontWeight.bold),),
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
                        final int count = int.tryParse(_numberController.text) ?? 0;
                        generateRandomNumbers(count);
                      },
                      child: Text('Generar Números'),
                      style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 52, 145, 55),
                                ),
                    ),
                  ],
                ),
                if (randomNumbers.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text('Números generados:'),
                  Text(randomNumbers.join(", ")),
                ],
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  shrinkWrap: true,
                  children: [
                    buildGridButton(Colors.orange ,Icons.sort, 'Bubble Sort', () {
                      sortNumbersWithBubbleSort();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Números ordenados (Bubble Sort)'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(sortedRandomNumbers.join(", ")),
                                SizedBox(height: 10),
                                Text('Tiempo de ordenamiento: ${sortingTime} ms'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cerrar', style: TextStyle(color: const Color.fromARGB(255, 163, 45, 37), fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SimulationView(
                                        originalNumbers: randomNumbers,
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


                    buildGridButton(const Color.fromARGB(255, 41, 119, 157), Icons.sort, 'Insertion Sort', () {
                      sortNumbersWithInsertionSort();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Números ordenados (Insertion Sort)'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(sortedRandomNumbers.join(", ")),
                                SizedBox(height: 10),
                                Text('Tiempo de ordenamiento: ${sortingTime} ms'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cerrar', style: TextStyle(color: const Color.fromARGB(255, 163, 45, 37), fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SimulationViewInsertion(
                                        originalNumbers: randomNumbers,
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

                    buildGridButton(Color.fromARGB(255, 214, 49, 156), Icons.sort, 'Merge Sort', () {
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
                                child: Text('Cerrar', style: TextStyle(color: const Color.fromARGB(255, 163, 45, 37), fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SimulationViewMerge(
                                        originalNumbers: randomNumbers,
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

                    buildGridButton(Color.fromARGB(255, 65, 136, 30), Icons.sort, 'Shell Sort', () {
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
                                Text('Tiempo de ordenamiento: ${sortingTime} ms'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cerrar', style: TextStyle(color: const Color.fromARGB(255, 163, 45, 37), fontWeight: FontWeight.bold)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SimulationViewShell(
                                        originalNumbers: randomNumbers,
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
