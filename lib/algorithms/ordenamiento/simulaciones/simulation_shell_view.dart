import 'package:flutter/material.dart';

class SimulationViewShell extends StatefulWidget {
  final List<int> originalNumbers;
  final List<int> sortedNumbers;

  SimulationViewShell({required this.originalNumbers, required this.sortedNumbers});

  @override
  _SimulationViewShellState createState() => _SimulationViewShellState();
}

class _SimulationViewShellState extends State<SimulationViewShell> {
  List<int> numbers = [];
  int currentStep = 0;
  bool isSorting = false;

  @override
  void initState() {
    super.initState();
    numbers = List.from(widget.originalNumbers);
  }

  Future<void> startSorting() async {
    if (!isSorting) {
      isSorting = true;
      await shellSortAnimated(numbers);
      isSorting = false;
    }
  }

  Future<void> shellSortAnimated(List<int> arr) async {
    int n = arr.length;
    List<int> sortedList = List.from(arr);

    // Definir el espacio inicial (gap)
    int gap = n ~/ 3;

    while (gap > 0) {
      for (int i = gap; i < n; i++) {
        int temp = sortedList[i];
        int j = i;

        while (j >= gap && sortedList[j - gap] > temp) {
          sortedList[j] = sortedList[j - gap];
          j -= gap;

          // Pausa para animar
          setState(() {
            numbers = List.from(sortedList);
          });

          await Future.delayed(Duration(milliseconds: sortedList.length > 250 ? 10 : 500));
        }

        sortedList[j] = temp;
      }

      gap = gap ~/ 3;
    }

    setState(() {
      numbers = List.from(sortedList);
    });
  }

  void resetSimulation() {
    if (!isSorting) {
      setState(() {
        numbers = List.from(widget.originalNumbers);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simulación de Shell Sort'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color.fromARGB(255, 65, 136, 30),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: numbers.length > 250 ? 10 : 500),
                  height: isSorting ? 200 : 0,
                  width: 600,
                  child: CustomPaint(
                    size: Size(400, 200),
                    painter: HistogramPainterShell(numbers),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isSorting && currentStep == 0)
                      ElevatedButton(
                        onPressed: startSorting,
                        child: Text('Iniciar Ordenamiento'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 52, 145, 55),
                        ),
                      ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: resetSimulation,
                      child: Text('Reiniciar'),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 136, 46, 46),
                      ),
                    ),
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


class HistogramPainterShell extends CustomPainter {
  final List<int> numbers;
  final int maxNumber;

  HistogramPainterShell(this.numbers)
      : maxNumber = numbers.reduce((value, element) => value > element ? value : element);

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / (numbers.length * 2 + 1);
    final maxBarHeight = size.height * 0.8;
    var x = barWidth;
    final barSpacing = barWidth;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < numbers.length; i++) {
      final barHeight = (numbers[i] / maxNumber) * maxBarHeight;
      final y = size.height - barHeight;

      final paint = Paint()
        ..color = Color.fromARGB(255, 65, 136, 30)
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromPoints(Offset(x, y), Offset(x + barWidth, size.height)),
        paint,
      );

      textPainter.text = TextSpan(
        text: numbers.length < 20 ? numbers[i].toString() : "",
        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      );
      textPainter.layout(minWidth: 0, maxWidth: barWidth);
      textPainter.paint(
        canvas,
        Offset(x + barWidth / 2 - textPainter.width / 2, y - 20),
      );

      x += barWidth + barSpacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
