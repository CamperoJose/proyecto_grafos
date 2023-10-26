import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  final int modo;
  final int joinModo;
  final Function(int) onTap;

  MyBottomAppBar({
    required this.modo,
    required this.joinModo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color:  Colors.white,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,

        children: [
          SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: () {
              onTap(1);
            },
            backgroundColor: Colors.green,
            child: Icon(
              Icons.add_circle_outline_sharp,
              size: 30,
            ),
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }
}
