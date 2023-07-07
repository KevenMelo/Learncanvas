import 'dart:math';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'dart:math' as math;

import 'linkedList/linked.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.dark(),
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var index = 0;
  final data = LinkedList<Widget>();
  List<RenderParametersManager> parametersManager = [];
  List<int> idsUnique = [];
  bool showArrows = true;
  bool right = true;

  bool rightOrLeft = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int soma = 0;
    for (var i = 1; i < 1000; i++) {
      print(soma += i);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            for (var i = 0; i < data.length + 1; i++) ...{
              if (data.length > (i + 1)) ...{
                FutureBuilder(
                    future: Future.delayed(
                        const Duration(milliseconds: 10), () => 1),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CustomPaint(
                          foregroundPainter: ArrowPainter(
                              offSet1: _howOffSetStartUse(i),
                              //  Offset(
                              //     parametersManager[i]
                              //         .getRenderData(idsUnique[i].toString())!
                              //         .xRight,
                              //     parametersManager[i]
                              //         .getRenderData(idsUnique[i].toString())!
                              //         .yCenter),

                              offSet2: _howOffSetEndUse(i + 1),
                              //  Offset(
                              //     parametersManager[i + 1]
                              //         .getRenderData(
                              //             idsUnique[i + 1].toString())!
                              //         .xLeft,
                              //     parametersManager[i + 1]
                              //         .getRenderData(
                              //             idsUnique[i + 1].toString())!
                              //         .yCenter),

                              right: right),
                        );
                      }
                      return Container();
                    })
              }
            },
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: genWidTest(data),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Random random = Random();
        parametersManager.add(RenderParametersManager());
        idsUnique.add(index);
        setState(() {});
        data.append(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RenderMetricsObject(
              manager: parametersManager[index],
              id: idsUnique[index].toString(),
              child: Container(
                color: Color.fromARGB(255, random.nextInt(255),
                    random.nextInt(255), random.nextInt(255)),
                height: 100,
                width: 100,
                child: Align(
                    alignment: Alignment.centerRight, child: Text('$index')),
              ),
            ),
          ),
        );
        index++;
        dynamic teste;
        Future.delayed(Duration(seconds: 2), () {
          teste = parametersManager[index - 1]
              .getRenderData(idsUnique[index - 1].toString());
          print(teste);
        });
      }),
    );
  }

  Offset _howOffSetEndUse(int i) {
    bool control = i % 7 == 0;
    double dx = control
        ? parametersManager[i].getRenderData(idsUnique[i].toString())!.xCenter
        : rightOrLeft
            ? parametersManager[i]
                    .getRenderData(idsUnique[i].toString())!
                    .xRight +
                15
            : parametersManager[i]
                .getRenderData(idsUnique[i].toString())!
                .xLeft;
    //XRight
    //
    double dy = control
        ? parametersManager[i].getRenderData(idsUnique[i].toString())!.yTop
        : parametersManager[i].getRenderData(idsUnique[i].toString())!.yCenter;
    if (control) {
      rightOrLeft = !rightOrLeft;
    }

    return Offset(dx, dy);
  }

  Offset _howOffSetStartUse(int i) {
    bool control = (i + 1) % 7 == 0;
    double dx = control
        ? parametersManager[i].getRenderData(idsUnique[i].toString())!.xCenter
        : rightOrLeft
            ? parametersManager[i].getRenderData(idsUnique[i].toString())!.xLeft
            : parametersManager[i]
                .getRenderData(idsUnique[i].toString())!
                .xRight;
    //xLeft
    double dy = control
        ? parametersManager[i].getRenderData(idsUnique[i].toString())!.yBottom
        : parametersManager[i].getRenderData(idsUnique[i].toString())!.yCenter;

    return Offset(dx, dy);
  }

  //6 columns for each row
  List<Widget> genWidTest(LinkedList<Widget> linkedinList) {
    var w = <Widget>[];
    // int roundedNumber =
    int roundCorrect = (linkedinList.length / 7).floor();

    int k = 0;
    for (var i = 0;
        i <
            (roundCorrect == 0 && linkedinList.isNotEmpty
                ? 1
                : roundCorrect + 1);
        i++) {
      w.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Row(
            textDirection: i % 2 == 0 ? TextDirection.ltr : TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var j = 0;
                  j <
                      (k + 7 > linkedinList.length
                          ? linkedinList.length % 7
                          : 7);
                  j++) ...{
                linkedinList.elementAt(k + j),
              }
            ]),
      ));
      k += 7;
    }
    return w;
  }
}

/* 
 */

class ArrowPainter extends CustomPainter {
  Offset? offSet1;
  Offset? offSet2;

  bool right = false;
  ArrowPainter(
      {required this.offSet1, required this.offSet2, required this.right});
  @override
  void paint(Canvas canvas, Size size) {
    if (offSet2 != null) {
      var paint = Paint();
      var path = Path();
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 4;
      paint.color = Colors.black;

      if (offSet1 != null && offSet2 != null) {
        Offset element1 = offSet1!;
        Offset element2 = offSet2!;
        element1 = Offset(element1.dx + 10, element1.dy);
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
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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

    canvas.drawPath(path, paint);

    final angle = 9;

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
