import 'package:flutter/material.dart';

class GraphTypeDropdown extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const GraphTypeDropdown({
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _GraphTypeDropdownState createState() => _GraphTypeDropdownState();
}

class _GraphTypeDropdownState extends State<GraphTypeDropdown> {
  late bool isDirected;

  @override
  void initState() {
    super.initState();
    isDirected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Tipo de Grafo: "),
        SizedBox(width: 10),
        DropdownButton<bool>(
          value: isDirected,
          onChanged: (newValue) {
            setState(() {
              isDirected = newValue!;
              widget.onChanged(isDirected);
            });
          },
          items: [
            DropdownMenuItem<bool>(
              value: true,
              child: Row(
                children: [
                  Icon(Icons.arrow_forward, color: Colors.blue),
                  SizedBox(width: 5),
                  Text("Es Dirigido", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            DropdownMenuItem<bool>(
              value: false,
              child: Row(
                children: [
                  Icon(Icons.remove, color: Colors.green),
                  SizedBox(width: 5),
                  Text("No es Dirigido", style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
