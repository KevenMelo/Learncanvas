import 'package:flutter/material.dart';
import 'package:graphite/graphite.dart';
import 'dart:math' as math;

import 'package:render_metrics/render_metrics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<RenderParametersManager> parametersManager = [];
  bool showArrows = true;
  bool right = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(
      child: Stack(children: [
        for (var j = 0; j < 4; j++) ...{
          Row(
            children: [
              // for (var i = 0; i < 3; i++) ...{
                CustomPaint(
                    // foregroundPainter: i % 3 != 0
                    //     ?
                    foregroundPainter: ArrowPainter(
                        testeKey1: parametersManager[1 + j],
                        testeKey2: parametersManager[ 1 + j],
                        right: right)
                    // : i % 2 == 0
                    //     ? ArrowPainterCurvedLeft(
                    //         testeKey1: parametersManager[i],
                    //         testeKey2: parametersManager[(i + j) + 1])
                    //     : ArrowPainterCurved(
                    //         testeKey1: parametersManager[i],
                    //         testeKey2: parametersManager[(i + j) + 1]),
                    ),
                Container(
                  color: Colors.grey,
                  height: 100,
                  width: 100,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('${j}')),
                ),
              // }
            ],
          )
        },
      ]),
    ));
  }
}

class ArrowPainterCurved extends CustomPainter {
  GlobalKey testeKey1;
  GlobalKey testeKey2;
  ArrowPainterCurved({required this.testeKey1, required this.testeKey2});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.color = Colors.black;
    RenderBox? renderKey1 =
        testeKey1.currentContext?.findRenderObject() as RenderBox;
    RenderBox? renderKey2 =
        testeKey2.currentContext?.findRenderObject() as RenderBox;
    Offset element1 = renderKey1.localToGlobal(Offset.zero);
    Offset element2 = renderKey2.localToGlobal(Offset.zero);
    element1 = Offset(element1.dx + 40, element1.dy);
    element2 = Offset(element2.dx + 20, element2.dy);
    Path path = Path();

    path.moveTo(element1.dx, element1.dy);
    path.quadraticBezierTo(
        element1.dx + 300, element1.dy, element2.dx + 2, element2.dy);
    // path.lineTo(element2.dx, element2.dy);

    canvas.drawPath(path, paint);
    // canvas.drawLine(element1, element2, paint);
    // final dX = element2.dx - element1.dx;
    // final dY = element2.dy - element1.dy;
    // final dX = element1.dx - element2.dx;
    // final dY = element2.dy - element1.dy;
    final angle = 9;
    // : math.atan2(dY, dX);

    const arrowSize = 15;
    const arrowAngle = 25 * math.pi / 180;
    path.moveTo(element2.dx - arrowSize * math.cos(angle - arrowAngle),
        element2.dy - arrowSize * math.sin(angle - arrowAngle));
    path.lineTo(element2.dx, element2.dy);
    path.lineTo(element2.dx - arrowSize * math.cos(angle + arrowAngle),
        element2.dy - arrowSize * math.sin(angle + arrowAngle));
    path.close();
    canvas.drawPath(path, paint);
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class ArrowPainterCurvedLeft extends CustomPainter {
  GlobalKey testeKey1;
  GlobalKey testeKey2;

  ArrowPainterCurvedLeft({required this.testeKey1, required this.testeKey2});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.color = Colors.black;

    RenderBox? renderKey1 =
        testeKey1.currentContext?.findRenderObject() as RenderBox;
    RenderBox? renderKey2 =
        testeKey2.currentContext?.findRenderObject() as RenderBox;
    Offset element1 = renderKey1.localToGlobal(Offset.zero);
    Offset element2 = renderKey2.localToGlobal(Offset.zero);
    element1 = Offset(element1.dx, element1.dy);
    element2 = Offset(element2.dx, element2.dy);
    path.moveTo(element1.dx, element1.dy);
    path.quadraticBezierTo(element2.dx / 11, element2.dy / 1.3,
        element2.dx - 23, element2.dy - 15);
    canvas.drawPath(path, paint);
    final arrowPath = Path();
    final dX = element2.dx - element1.dx;
    final dY = element2.dy - element1.dy;
    final angle = math.atan2(dY, dX);
    const arrowSize = 15;
    const arrowAngle = 38 * math.pi / 107;
    arrowPath.moveTo(
        element2.dx - 20 - arrowSize * math.cos(angle - arrowAngle + 6),
        element2.dy - 25 - arrowSize * math.sin(angle - arrowAngle));
    arrowPath.lineTo(element2.dx - 20, element2.dy - 15);
    arrowPath.lineTo(
        element2.dx - arrowSize + 25 * math.cos(angle + arrowAngle),
        element2.dy - 5 - arrowSize * math.sin(angle + arrowAngle));
    arrowPath.close();
    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class ArrowPainter extends CustomPainter {
  RenderParametersManager testeKey1;
  RenderParametersManager testeKey2;
  dynamic id1;
  dynamic id2;
  bool right = false;
  ArrowPainter(
      {required this.testeKey1, required this.testeKey2, required this.right});
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    var paint = Paint();
    var path = Path();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.color = Colors.black;

    // RenderBox? renderKey1 =
    //     testeKey1.currentContext?.findRenderObject() as RenderBox;
    // RenderBox? renderKey2 =
    //     testeKey2.currentContext?.findRenderObject() as RenderBox;

    Offset element1 = Offset(testeKey1.getRenderData(id1)!.xCenter,
        testeKey1.getRenderData(id1)!.yCenter);
    //  renderKey1.localToGlobal(Offset.zero);
    Offset element2 = Offset(testeKey2.getRenderData(id2)!.xCenter,
        testeKey2.getRenderData(id2)!.yCenter);

    // Offset element2 =
    //  renderKey2.localToGlobal(Offset.zero);
    element1 = Offset(element1.dx, element1.dy);
    element2 =
        Offset((right ? element2.dx - 10 : element2.dx + 15), element2.dy);
    path.moveTo(element1.dx, element1.dy);
    canvas.drawLine(element1, element2, paint);
    final dX = element2.dx - element1.dx;
    final dY = element2.dy - element1.dy;
    final angle = math.atan2(dY, dX);
    const arrowSize = 15;
    const arrowAngle = 25 * math.pi / 180;
    path.moveTo(element2.dx - arrowSize * math.cos(angle - arrowAngle),
        element2.dy - arrowSize * math.sin(angle - arrowAngle));
    path.lineTo(element2.dx, element2.dy);
    path.lineTo(element2.dx - arrowSize * math.cos(angle + arrowAngle),
        element2.dy - arrowSize * math.sin(angle + arrowAngle));
    path.close();
    canvas.drawPath(path, paint);
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class Node<T> {
  T value;
  Node<T>? next;
  Node({required this.value, this.next});
}

class LinkedList<E> {
  Node<E>? head;
  Node<E>? tail;

  bool get isEmpty => head == null;
  @override
  String toString() {
    if (isEmpty) return 'Empty List';
    return head.toString();
  }

  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
  }

  void append(E value) {
    if (isEmpty) {
      push(value);
    }

    tail!.next = Node(value: value);
    tail = tail!.next;
  }
}
