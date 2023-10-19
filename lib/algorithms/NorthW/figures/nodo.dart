import 'package:flutter/material.dart';

import '../Clases north/modelo_nodoN.dart';


class Nodo extends CustomPainter {
  List<ModeloNodoN> vNodo;
  Nodo(this.vNodo);

  _drawNode(Canvas canvas, Paint paint, double x, double y, double radius) {
    paint.color = Colors.purple.shade900;
    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  _drawText(Canvas canvas, String text, double x, double y, double nodeWidth) {
    TextSpan span = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      text: text,
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    double scaleFactor = 1.0;
    if (tp.width > nodeWidth) {
      scaleFactor = nodeWidth / tp.width;
    }

    if (scaleFactor < 1.0) {
      tp.text = TextSpan(
        text: text.length < 11 ? text : text.substring(0, 9) + '...',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25 * scaleFactor,
          fontWeight: FontWeight.bold,
        ),
      );
      tp.layout();
    }

    canvas.drawCircle(Offset(x, y), nodeWidth / 2, Paint()..color = Colors.purple.shade400);
    tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var nodo in vNodo) {
      double nodeWidth = nodo.radio * 2;
      _drawText(canvas, nodo.mensaje, nodo.x, nodo.y, nodeWidth);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
