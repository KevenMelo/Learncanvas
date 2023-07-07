import 'package:flutter/material.dart';
import 'package:graphite/graphite.dart';
import 'package:widget_arrows/arrows.dart';
import 'package:widget_arrows/widget_arrows.dart';

void main() => runApp(MyApp());
const list = '['
    '{"id":"A","next":[{"outcome":"B"}]},'
    '{"id":"B","next":[{"outcome":"C"},{"outcome":"D"},{"outcome":"E"}]},'
    '{"id":"C","next":[{"outcome":"F"}]},'
    '{"id":"D","next":[{"outcome":"J"}]},{"id":"E","next":[{"outcome":"J"}]},'
    '{"id":"J","next":[{"outcome":"I"}]},'
    '{"id":"I","next":[{"outcome":"H"}]},{"id":"F","next":[{"outcome":"K"}]},'
    '{"id":"K","next":[{"outcome":"L"}]},'
    '{"id":"H","next":[{"outcome":"L"}]},{"id":"L","next":[{"outcome":"P"}]},'
    '{"id":"P","next":[{"outcome":"M"},{"outcome":"N"}]},'
    '{"id":"M","next":[]},{"id":"N","next":[]}'
    ']';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Graphite',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showArrow = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArrowElement(
          id: '1',
          targetId: '2',
          arcDirection: ArcDirection.Right,
          show: showArrow,
          color: Colors.red,
          sourceAnchor: Alignment.bottomCenter,
          child: DirectGraph(
            list: listNodeInput(),
            // nodeInputFromJson(list),
            defaultCellSize: const Size(100.0, 100.0),
            cellPadding: const EdgeInsets.all(20),
            orientation: MatrixOrientation.Horizontal,
          ),
        ),
        // ArrowElement(id: 'init', targetId: 'alvo', child: Text('arrow Init')),
        // SizedBox(
        //   height: 300,
        // ),
        // ArrowElement(id: 'alvo', child: Text('Arrow alvo')),
        ArrowElement(
          id: '2',
          show: showArrow,
          targetAnchor: Alignment.centerRight,
          child: DirectGraph(
            list: listNodeInput(),
            // nodeInputFromJson(list),
            defaultCellSize: const Size(100.0, 100.0),
            cellPadding: const EdgeInsets.all(20),
            orientation: MatrixOrientation.Horizontal,
          ),
        ),
      ],
    ));
  }

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

const presetComplex = '['
    '{"id":"A","next":[{"outcome":"B","type":"one"}]},'
    '{"id":"U","next":[{"outcome":"G","type":"one"}]},'
    '{"id":"B","next":[{"outcome":"C","type":"one"},{"outcome":"D","type":"one"},{"outcome":"E","type":"one"},{"outcome":"F","type":"one"},{"outcome":"M","type":"one"}]},'
    '{"id":"C","next":[{"outcome":"G","type":"one"}]},'
    '{"id":"D","next":[{"outcome":"H","type":"one"}]},'
    '{"id":"E","next":[{"outcome":"H","type":"one"}]},'
    '{"id":"F","next":[{"outcome":"W","type":"one"},{"outcome":"N","type":"one"},{"outcome":"O","type":"one"}]},'
    '{"id":"W","next":[]},'
    '{"id":"N","next":[{"outcome":"I","type":"one"}]},'
    '{"id":"O","next":[{"outcome":"P","type":"one"}]},'
    '{"id":"P","next":[{"outcome":"I","type":"one"}]},'
    '{"id":"M","next":[{"outcome":"L","type":"one"}]},'
    '{"id":"G","next":[{"outcome":"I","type":"one"}]},'
    '{"id":"H","next":[{"outcome":"J","type":"one"}]},'
    '{"id":"I","next":[]},'
    '{"id":"J","next":[{"outcome":"K","type":"one"}]},'
    '{"id":"K","next":[{"outcome":"L","type":"one"}]},'
    '{"id":"L","next":[]}'
    ']';

class Painter extends CustomPainter {
  Offset startOffset;
  Offset endOffset;
  Painter({required this.startOffset, required this.endOffset});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(startOffset, endOffset, Paint());
    // canvas.drawArc(Rect.largest, 10, 15, true, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomEdgesPage extends StatefulWidget {
  const CustomEdgesPage({Key? key}) : super(key: key);
  @override
  CustomEdgesPageState createState() {
    return CustomEdgesPageState();
  }
}

class CustomEdgesPageState extends State<CustomEdgesPage> {
  List<NodeInput> list = nodeInputFromJson(presetComplex);
  Map<String, bool> selected = {};
  void _onItemSelected(String nodeId) {
    setState(() {
      selected[nodeId] =
          selected[nodeId] == null || !selected[nodeId]! ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          leading: const Icon(Icons.view_comfy),
          title: const Text('Custom Edges Example')),
      body: InteractiveViewer(
        maxScale: 1000,
        minScale: 0.0001,
        constrained: false,
        child: DirectGraph(
          list: list,
          defaultCellSize: const Size(104.0, 104.0),
          cellPadding: const EdgeInsets.all(14),
          contactEdgesDistance: 5.0,
          orientation: MatrixOrientation.Horizontal,
          pathBuilder: customEdgePathBuilder,
          centered: false,
          onEdgeTapDown: (details, edge) {
            print("${edge.from.id}->${edge.to.id}");
          },
          nodeBuilder: (ctx, node) {
            return Card(
              child: Center(
                child: Text(
                  node.id,
                  style: selected[node.id] ?? false
                      ? const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)
                      : const TextStyle(fontSize: 20.0),
                ),
              ),
            );
          },
          paintBuilder: (edge) {
            var p = Paint()
              ..color = Colors.blueGrey
              ..style = PaintingStyle.stroke
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round
              ..strokeWidth = 2;
            if ((selected[edge.from.id] ?? false) &&
                (selected[edge.to.id] ?? false)) {
              p.color = Colors.red;
            }
            return p;
          },
          onNodeTapDown: (_, node, __) {
            _onItemSelected(node.id);
          },
        ),
      ),
    );
  }
}

Path customEdgePathBuilder(NodeInput from, NodeInput to,
    List<List<double>> points, EdgeArrowType arrowType) {
  var path = Path();
  path.moveTo(points[0][0], points[0][1]);
  points.sublist(1).forEach((p) {
    path.lineTo(p[0], p[1]);
  });
  return path;
}

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        width: 100,
        child: ListView(
          children: [
            Container(
                color: Colors.grey, height: 10, width: 10, child: Text('1')),
            Container(height: 10, width: 10, child: Text('2')),
          ],
        ));
  }
}
