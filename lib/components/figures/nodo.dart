
import 'package:flutter/material.dart';

import '../../classes/modelo_nodo.dart';

class Nodo extends CustomPainter {
  List<ModeloNodo> vNodo;
  Nodo(this.vNodo);

  _msg(double x, double y, String msg, Canvas canvas) {
    TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        text: msg);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);

    tp.layout();
    tp.paint(canvas, Offset(x, y));
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    for (var nodo in vNodo) {
      paint.color = Colors.purple;
      canvas.drawCircle(Offset(nodo.x, nodo.y), nodo.radio, paint);

      _msg(nodo.x - 6, nodo.y - 13, nodo.mensaje, canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
