import 'package:flutter/material.dart';
import 'package:hapa/lib/News/ui/screens/NewsPage.dart';

class News extends StatelessWidget {

  String description;
  String img;
  String titulo;
  News(this.img,this.titulo, this.description);
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


    final barra = new Container(
      height: 15.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black45,
            Colors.black26
          ],

          stops: [0.0, 0.6],
          tileMode: TileMode.clamp,
        )
      ),
    );
    final title = new Container(
      child: Text(
        titulo,
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 25.0,
          fontWeight: FontWeight.w900,
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

    final descriptionField = Container(
      margin: new EdgeInsets.only(
        top: 5.0,
        right: 20.0,
        left: 10.0,
      ),
      child: new Text(
        description,
        style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Color(0xff56575a)
        ),
      ),
    );




    return GestureDetector(
        // Cuando el hijo reciba un tap, muestra un snackbar
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new NewsPage(img, titulo)));
    },
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        barra,
        photo,
        title,
        descriptionField
      ],
      )
    );
  }
}
