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
  bool showArrows = true;

  @override
  Widget build(BuildContext context) => ArrowContainer(
        child: Scaffold(
            body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: listNode(),
            ),
          ),
        )),
      );

  List<Widget> listNode() {
    List<Widget> list = [];
    for (var i = 0; i < 3; i++) {
      List<Widget> temporaryList = [];
      for (var j = 0; j < 3; j++) {
        int id = j + 1;
        temporaryList.add(ArrowElement(
          id: '${i + id}',
          targetId: '${++i + id++}',
          child: Container(
            color: Colors.grey,
            height: 100,
            width: 100,
            child: Text('${i + id}'),
          ),
        ));
      }
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: temporaryList,
      ));
    }
    return list;
  }
}
