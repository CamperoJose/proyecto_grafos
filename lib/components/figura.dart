import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Figura extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill// .. se utilizan para encadenar metodos
      ..color = Colors.amber;

    canvas.drawCircle(Offset(200, 300), 50, paint);

    paint.color = Colors.blue;

    canvas.drawRect(Rect.fromLTWH(0, 0, 200, 200), paint);

    paint.color = Colors.red;

    canvas.drawRRect(
        RRect.fromLTRBR(600, 0, 200, 200, Radius.circular(20)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}