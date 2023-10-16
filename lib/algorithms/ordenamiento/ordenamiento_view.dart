import 'dart:math';
import 'package:flutter/material.dart';
import 'bubble_sort.dart';
import 'simulation_view.dart';

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

  Widget buildGridButton(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 5),
          Text(label, textAlign: TextAlign.center),
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
                Text('Ingrese la cantidad de números a generar:'),
                SizedBox(height: 10),
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
                    SizedBox(width: 10),
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
                  SizedBox(height: 20),
                  Text('Números generados:'),
                  Text(randomNumbers.join(", ")),
                ],
                SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: [
                    buildGridButton(Icons.sort, 'Bubble Sort', () {
                      sortNumbersWithBubbleSort();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Números ordenados (Bubble Sort)'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(sortedRandomNumbers.join(", ")),
                                SizedBox(height: 10),
                                Text('Tiempo de ordenamiento: ${sortingTime.inMilliseconds} ms'),
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
                    // Puedes agregar botones para otros algoritmos aquí en el futuro
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
