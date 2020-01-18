import 'package:flutter/material.dart';
import 'package:hapa/lib/News/ui/screens/SideMenu.dart';
import 'package:hapa/lib/News/ui/widgets/newsList.dart';

class HapaHome extends StatelessWidget {
  final topBar = new AppBar(
    backgroundColor: new Color.fromRGBO(243, 232, 178, 1),
    centerTitle: true,
    elevation: 1.0,
    title: SizedBox(
        height: 45.0, child: Image.asset("assets/images/hapa1.png")),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(Icons.send),
      )
    ],
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: topBar,
        drawer: new SideMenu(),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                NewsList(),
              ],
            ),
          ],
        ));
  }
}
