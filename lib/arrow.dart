import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphite/graphite.dart';
import 'package:widget_arrows/arrows.dart';
import 'package:widget_arrows/widget_arrows.dart';

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
  final StreamController<List<Widget>> _controller =
      StreamController.broadcast();
  List<Widget> _listTest = [];
  bool showArrows = true;
  List<String> ids = [];
  int lineCount = 0;
  int nodeCount = 0;
  @override
  Widget build(BuildContext context) => ArrowContainer(
        child: Scaffold(
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.8,
              child: StreamBuilder<List<Widget>>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Sem data');
                    }
                    return Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: snapshot.data!
                        // [
                        //   GroupLine(
                        //     ids: const ['1', '2'],
                        //     targetIds: const ['2'],
                        //     right: true,
                        //   ),
                        // ],
                        );
                  }),
            ),
          ),
          floatingActionButton: ArrowElement(
            id: 'fab',
            child: FloatingActionButton(
              onPressed: () => _generateDate(),
              tooltip: 'hide/show',
              child: const Icon(Icons.remove_red_eye),
            ),
          ),
        ),
      );

  void _generateDate() {
    List<Widget> widgets = [];
    for (var i = 0; i < ids.length; i++) {}
  }
}

class NodeModel {
  String id;
  String targetid;
  NodeModel({required this.id, required this.targetid});
}

class GroupLine extends StatelessWidget {
  List<String> ids;
  List<String> targetIds;
  final bool right;
  GroupLine(
      {super.key,
      required this.ids,
      required this.targetIds,
      required this.right});

  @override
  Widget build(BuildContext context) {
    if (right) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ArrowElement(
          id: ids[0],
          targetId: targetIds[0],
          targetAnchor: Alignment.centerLeft,
          sourceAnchor: Alignment.centerRight,
          color: Colors.black,
          child: Container(
            color: Colors.grey,
            height: 100,
            width: 100,
            child: Text(ids[0]),
          ),
        ),
        if (ids.length > 1)
          ArrowElement(
            id: ids[1],
            targetId: targetIds.length > 1 ? targetIds[1] : null,
            color: Colors.black,
            targetAnchor: Alignment.centerLeft,
            sourceAnchor: Alignment.centerRight,
            // targetAnchor: Alignment.topLeft,
            // sourceAnchor: Alignment.centerRight,
            child: Container(
              color: Colors.grey,
              height: 100,
              width: 100,
              child: Text(ids[1]),
            ),
          ),
        if (targetIds.length > 2 && ids.length > 2) ...{
          ArrowElement(
            id: ids[2],
            targetId: targetIds[2],
            color: Colors.black,
            arcDirection: ArcDirection.Right,
            targetAnchor: Alignment.centerRight,
            sourceAnchor: right ? Alignment.bottomCenter : Alignment.centerLeft,
            child: Container(
              color: Colors.grey,
              height: 100,
              width: 100,
              child: Text(ids[2]),
            ),
          ),
        } else ...{
          if (ids.length > 2)
            ArrowElement(
              id: ids[2],
              //targetId: 'text8',
              color: Colors.black,
              targetAnchor: Alignment.centerRight,
              sourceAnchor: Alignment.centerLeft,
              child: Container(
                color: Colors.grey,
                height: 100,
                width: 100,
                child: Text(ids[2]),
              ),
            ),
        }
      ]);
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        if (targetIds.length > 2 && ids.length > 2) ...{
          ArrowElement(
            id: ids[2],
            targetId: targetIds[2],
            targetAnchor: Alignment.topCenter,
            sourceAnchor: Alignment.centerLeft,
            color: Colors.black,
            child: Container(
              color: Colors.grey,
              height: 100,
              width: 100,
              child: Text(ids[2]),
            ),
          ),
        } else ...{
          if (ids.length > 2)
            ArrowElement(
              id: ids[2],
              targetAnchor: Alignment.topCenter,
              sourceAnchor: Alignment.centerLeft,
              color: Colors.black,
              child: Container(
                color: Colors.grey,
                height: 100,
                width: 100,
                child: Text(ids[2]),
              ),
            )
        },
        if (ids.length > 1)
          ArrowElement(
            id: ids[1],
            targetId: targetIds.length > 1 ? targetIds[1] : null,
            color: Colors.black,
            targetAnchor: Alignment.centerRight,
            sourceAnchor: Alignment.centerLeft,
            child: Container(
              color: Colors.grey,
              height: 100,
              width: 100,
              child: Text(ids[1]),
            ),
          ),
        ArrowElement(
          id: ids[0],
          targetId: targetIds[0],
          color: Colors.black,
          targetAnchor: Alignment.centerRight,
          sourceAnchor: Alignment.centerLeft,
          child: Container(
            color: Colors.grey,
            height: 100,
            width: 100,
            child: Text(ids[0]),
          ),
        ),
      ]);
    }
  }
}
