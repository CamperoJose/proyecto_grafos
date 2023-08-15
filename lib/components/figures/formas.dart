import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../classes/modelo_arista.dart';


class Union extends CustomPainter {
  List<ModeloArista> vUniones;
  Union(this.vUniones);

  _msg(double x, double y, String msg, Canvas canvas) {
    TextSpan span = TextSpan(
        style: const TextStyle(
            color: Colors.deepPurpleAccent, fontSize: 25, fontWeight: FontWeight.bold),
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
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..strokeWidth = 2;

    Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 2;

  for (var nodo in vUniones) {

    if(nodo.ida==true){
          paint.color = Colors.black;
    canvas.drawLine(Offset(nodo.xinicio, nodo.yinicio),
        Offset(nodo.xfinal, nodo.yfinal), paint);

    // calculate angle of the line
    double angle = atan2(nodo.yfinal - nodo.yinicio, nodo.xfinal - nodo.xinicio);

    // calculate coordinates of the arrow tip
    double arrowLength = 60;
    double arrowX = nodo.xfinal - arrowLength * cos(angle);
    double arrowY = nodo.yfinal - arrowLength * sin(angle);

    // draw the arrow
    Path path = Path();
    path.moveTo(nodo.xfinal - 30 * cos(angle), nodo.yfinal- 30 * sin(angle));
    path.lineTo(arrowX + 15 * cos(angle + pi / 6), arrowY + 15 * sin(angle + pi / 6));
    path.lineTo(arrowX + 15 * cos(angle - pi / 6), arrowY + 15 * sin(angle - pi / 6));
    path.close();
    canvas.drawPath(path, paint);

    _msg((nodo.xfinal +nodo.xinicio)/2, (nodo.yinicio+nodo.yfinal)/2, nodo.peso, canvas);
    }
    else{
      Path path = Path();
      path.moveTo(nodo.xinicio, nodo.yinicio);
      path.arcToPoint(
        Offset(nodo.xfinal, nodo.yfinal),
        radius: const Radius.circular(50),
        clockwise: true,
      );


      double angle =
          atan2(nodo.yfinal - nodo.yinicio, nodo.xfinal - nodo.xinicio) +pi*(17/40);

      // create a path for the arrow
      double arrowLength = 60;
      double arrowX = nodo.xfinal - arrowLength * cos(angle);
      double arrowY = nodo.yfinal - arrowLength * sin(angle);

      Path arrowPath = Path();
      arrowPath.moveTo(nodo.xfinal - 30 * cos(angle), nodo.yfinal - 30 * sin(angle));
      arrowPath.lineTo(
          arrowX + 15 * cos(angle + pi / 6), arrowY + 15 * sin(angle + pi / 6));
      arrowPath.lineTo(
          arrowX + 15 * cos(angle - pi / 6), arrowY + 15 * sin(angle - pi / 6));
      arrowPath.close();

      // draw the line and arrow
      canvas.drawPath(path, paint2);
      canvas.drawPath(arrowPath, paint);

      PathMetrics pathMetrics = path.computeMetrics();
      PathMetric pathMetric = pathMetrics.elementAt(0);
      Tangent tangent = pathMetric.getTangentForOffset(pathMetric.length / 2)!;
      Offset arrowPoint = tangent.position;
      double angle2 = tangent.angle;

      // draw the text
      _msg(arrowPoint.dx - 30 * cos(angle), arrowPoint.dy - 30 * sin(angle2) ,
          nodo.peso, canvas);
    }

  }
}
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

