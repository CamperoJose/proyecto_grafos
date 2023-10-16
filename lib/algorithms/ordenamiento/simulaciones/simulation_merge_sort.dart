import 'package:flutter/material.dart';

class SimulationViewMerge extends StatefulWidget {
  final List<int> originalNumbers;
  final List<int> sortedNumbers;

  SimulationViewMerge({required this.originalNumbers, required this.sortedNumbers});

  @override
  _SimulationViewMergeState createState() => _SimulationViewMergeState();
}

class _SimulationViewMergeState extends State<SimulationViewMerge> {
  List<int> numbers = [];
  int currentStep = 0;
  bool isSorting = false;

  @override
  void initState() {
    super.initState();
    numbers = List.from(widget.originalNumbers);
  }

void startSorting() async {
  if (!isSorting) {
    isSorting = true;
    await mergeSortAnimated(0, numbers.length - 1);
    isSorting = false;
  }
}

Future<void> mergeSortAnimated(int left, int right) async {
  if (left < right) {
    final int middle = (left + right) ~/ 2;
    await mergeSortAnimated(left, middle);
    await mergeSortAnimated(middle + 1, right);
    await mergeAnimated(left, middle, right);
  }
}

Future<void> mergeAnimated(int left, int middle, int right) async {
  final List<int> leftList = numbers.sublist(left, middle + 1);
  final List<int> rightList = numbers.sublist(middle + 1, right + 1);

  int leftIndex = 0, rightIndex = 0, mergedIndex = left;

  while (leftIndex < leftList.length && rightIndex < rightList.length) {
    if (leftList[leftIndex] <= rightList[rightIndex]) {
      numbers[mergedIndex] = leftList[leftIndex];
      leftIndex++;
    } else {
      numbers[mergedIndex] = rightList[rightIndex];
      rightIndex++;
    }
    mergedIndex++;

    // Pausa para animar
    setState(() {});

    await Future.delayed( Duration(milliseconds: numbers.length>250 ? 10 : 500));
  }

  while (leftIndex < leftList.length) {
    numbers[mergedIndex] = leftList[leftIndex];
    leftIndex++;
    mergedIndex++;

    // Pausa para animar
    setState(() {});

    await Future.delayed( Duration(milliseconds: numbers.length>250 ? 10 : 500));
  }

  while (rightIndex < rightList.length) {
    numbers[mergedIndex] = rightList[rightIndex];
    rightIndex++;
    mergedIndex++;

    // Pausa para animar
    setState(() {});

    await Future.delayed( Duration(milliseconds: numbers.length>250 ? 10 : 500));
  }
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
          title: Text('Simulación de Bubble Sort'),
          //boton de retroceder:
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          //color:
          backgroundColor: Color.fromARGB(255, 214, 49, 156),
        ),
        body: Container(

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: numbers.length>250 ? 10 : 500),
                  height: isSorting ? 200 : 0,
                  width: 600,
                  child: CustomPaint(
                    size: Size(400, 200),
                    painter: HistogramPainter(numbers),
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
                        //color:
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 52, 145, 55),
                        ),
                      ),
                      //espaciado:
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

class HistogramPainter extends CustomPainter {
  final List<int> numbers;
  final int maxNumber;

  HistogramPainter(this.numbers)
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
        ..color = Color.fromARGB(255, 214, 49, 156)
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromPoints(Offset(x, y), Offset(x + barWidth, size.height)),
        paint,
      );

      textPainter.text = TextSpan(
        text: numbers.length<20 ? numbers[i].toString() : "",
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
