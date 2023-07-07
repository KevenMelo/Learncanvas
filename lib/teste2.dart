import 'package:flutter/material.dart';
import 'package:graphite/graphite.dart';
import 'dart:math' as math;

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
  final GlobalKey _testeKey1 = GlobalKey();
  final GlobalKey _testeKey2 = GlobalKey();
  final GlobalKey _testeKey22 = GlobalKey();
  final GlobalKey _testeKey3 = GlobalKey();
  final GlobalKey _testeKey33 = GlobalKey();
  final GlobalKey _testeKey4 = GlobalKey();
  final GlobalKey _teste44 = GlobalKey();
  final GlobalKey _teste5 = GlobalKey();
  final GlobalKey _teste55 = GlobalKey();
  final GlobalKey _teste6 = GlobalKey();
  final GlobalKey _teste66 = GlobalKey();
  final GlobalKey _teste7 = GlobalKey();
  final GlobalKey _teste77 = GlobalKey();
  final GlobalKey _teste8 = GlobalKey();
  final GlobalKey _teste88 = GlobalKey();
  final GlobalKey _teste9 = GlobalKey();
  final GlobalKey _teste99 = GlobalKey();

  bool showArrows = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Stack(
            children: [
              CustomPaint(
                foregroundPainter: ArrowPainter(
                    right: true, testeKey1: _testeKey1, testeKey2: _testeKey2),
              ),
              CustomPaint(
                foregroundPainter: ArrowPainter(
                    right: true, testeKey1: _testeKey22, testeKey2: _testeKey3),
              ),
              CustomPaint(
                foregroundPainter: ArrowPainterCurved(
                    right: true, testeKey1: _testeKey33, testeKey2: _testeKey4),
              ),
              CustomPaint(
                foregroundPainter: ArrowPainterCurvedLeft(
                    testeKey1: _teste66, testeKey2: _teste7),
              ),
              CustomPaint(
                foregroundPainter: ArrowPainter(
                    right: false, testeKey1: _teste44, testeKey2: _teste5),
              ),
              CustomPaint(
                foregroundPainter: ArrowPainter(
                    right: false, testeKey1: _teste55, testeKey2: _teste6),
              ),
              Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(key: _testeKey1, '1')),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(key: _testeKey2, '2'),
                              Text(key: _testeKey22, '2.2')
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(key: _testeKey3, '3'),
                              Text(key: _testeKey33, '3.3'),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '66',
                                key: _teste66,
                              ),
                              Text(
                                '6',
                                key: _teste6,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '55',
                                key: _teste55,
                              ),
                              Text(key: _teste5, '5'),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(key: _teste44, '4.4'),
                              Text(key: _testeKey4, '4'),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '7',
                                key: _teste7,
                              ),
                              Text('77', key: _teste77)
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '8',
                                key: _teste8,
                              ),
                              Text(
                                '88',
                                key: _teste88,
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 100,
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '9',
                                key: _teste9,
                              ),
                              Text('99')
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
            ],
          ),
        ),
      );

  List<NodeInput> listNodeInput() {
    List<NodeInput> list = [];
    for (var i = 0; i < 5; i++) {
      if (i < 4) {
        list.add(NodeInput(id: '$i', next: [
          EdgeInput(outcome: '${i + 1}'),
        ]));
      } else {
        list.add(NodeInput(id: '$i', next: []));
      }
    }
    return list;
  }
}

class ArrowPainterCurved extends CustomPainter {
  GlobalKey testeKey1;
  GlobalKey testeKey2;
  bool right = true;
  ArrowPainterCurved(
      {required this.testeKey1, required this.testeKey2, required this.right});
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
    path.quadraticBezierTo(right ? element1.dx + 300 : element1.dx - 200,
        element1.dy, right ? element2.dx + 2 : element2.dx - 30, element2.dy);
    // path.lineTo(element2.dx, element2.dy);

    canvas.drawPath(path, paint);
    // canvas.drawLine(element1, element2, paint);
    // final dX = element2.dx - element1.dx;
    // final dY = element2.dy - element1.dy;
    // final dX = element1.dx - element2.dx;
    // final dY = element2.dy - element1.dy;
    if (right) {
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
    } else {
      final angle = 9;
      var arrowPaint = Paint();
      var arrowPath = Path();
      arrowPaint.style = PaintingStyle.stroke;
      arrowPaint.strokeWidth = 4;
      arrowPaint.color = Colors.red;
      const arrowSize = 15;
      const arrowAngle = 25 * math.pi / 180;
      arrowPath.moveTo(element2.dx - 40, element2.dy);

      arrowPath.lineTo(element2.dx - 40, element2.dy);
      arrowPath.lineTo(element2.dx - arrowSize * math.cos(angle + arrowAngle),
          element2.dy - arrowSize * math.sin(angle + arrowAngle));
      arrowPath.close();
      canvas.drawPath(arrowPath, arrowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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

    // final angle = math.atan2(dY, dX);
    // const arrowSize = 9;
    // const arrowAngle = 25 * math.pi / 180;
    // final arrowPath = Path();
    // arrowPath.moveTo(
    //     (element2.dx - 25) - arrowSize * math.cos(angle - arrowAngle),
    //     element2.dy + 2 - arrowSize * math.sin(angle - arrowAngle));
    // arrowPath.lineTo(element2.dx - 20, element2.dy - 27);
    // arrowPath.lineTo(
    //     element2.dx - 12 - arrowSize * math.cos(angle + arrowAngle),
    //     (element2.dy + 1) - arrowSize * math.sin(angle + arrowAngle));
    // arrowPath.close();
    // canvas.drawPath(arrowPath, paint);
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class ArrowPainter extends CustomPainter {
  GlobalKey testeKey1;
  GlobalKey testeKey2;

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

    RenderBox? renderKey1 =
        testeKey1.currentContext?.findRenderObject() as RenderBox;
    RenderBox? renderKey2 =
        testeKey2.currentContext?.findRenderObject() as RenderBox;
    Offset element1 = renderKey1.localToGlobal(Offset.zero);
    Offset element2 = renderKey2.localToGlobal(Offset.zero);
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
