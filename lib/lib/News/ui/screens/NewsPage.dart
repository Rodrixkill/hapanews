import 'package:flutter/material.dart';
import 'package:hapaprueba/News/model/newsModel.dart';

class NewsPage extends StatelessWidget{
  NewsModel newsModel;
  NewsPage(this.newsModel);
  @override
  Widget build(BuildContext context) {
    final photo = Container(
        width: MediaQuery.of(context).size.width,
        height: 270.0,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(newsModel.photoURL)
          ),
        )
    );
    final title = new Container(

      child: Text(
        newsModel.title,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 38.0,
          fontWeight: FontWeight.w700,
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

    final content = new Container(
      margin: new EdgeInsets.only(
        top: 5.0,
        right: 20.0,
        left: 10.0,
      ),
      child: Text(
        newsModel.content,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
          color: Colors.black,
        ),
      ),
    );
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            photo,
            title,
            content
          ],
        )
      ],
    );


  }


}