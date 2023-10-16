import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'matrix_viewNorth.dart';

class MySpeedDial extends StatelessWidget {
  MySpeedDial(context);
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.view_list,
      animatedIconTheme: IconThemeData(size: 22.0),
      backgroundColor: Colors.lightBlue.shade900,
      visible: true,
      children: [
        SpeedDialChild(
          child: Icon(Icons.table_chart_outlined),
          backgroundColor: Colors.orange.shade600,
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MatrixView()));
          },
          label: 'Generar Matriz',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.orange.shade600,
        ),
      ],
    );
  }
}