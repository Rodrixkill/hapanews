import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget{
  String img;
  String titulo;
  NewsPage(this.img, this.titulo);
  @override
  Widget build(BuildContext context) {
    final photo = Container(
        width: MediaQuery.of(context).size.width,
        height: 270.0,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(img)
          ),
        )
    );
    final title = new Container(
      child: Text(
        titulo,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 50.0,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        textAlign: TextAlign.left,
      ),
      margin: new EdgeInsets.only(
        top: 5.0,
        right: 20.0,
        left: 20.0,
      ),
      alignment: Alignment.centerLeft,
    );
    return Column(
      children: <Widget>[
        photo,
        title,
      ],
    );

  }


}