import 'package:flutter/material.dart';

class TopBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: new Color.fromRGBO(243, 232, 178, 1),
      centerTitle: true,
      elevation: 1.0,
      title: SizedBox(
          height: 35.0, child: Image.asset("assets/images/hapa1.png")),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12.0),

        )
      ],
    );
  }

}