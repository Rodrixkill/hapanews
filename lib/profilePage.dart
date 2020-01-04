import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  String backgroundPic = "assets/images/background1.png";
  String nombre = "Alejandra Picon";
  String titulo;
  String profipic;
  String descriccion = "Cuando recuperes o descubras algo que alimenta tu alma y te trae  alegría, encargate de quererte lo suficiente y hazle un espacio en tu vida (Jean Shinoda Bolen)";
  ProfilePage(this.titulo, this.nombre,this.descriccion, this.backgroundPic,this.profipic);
  @override
  Widget build(BuildContext context) {
    final background = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.5 ,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(backgroundPic)
          ),
        )
    );


    final profileImage = Center (
      child: Container(

          width: 170.0,
          height: 170.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(profipic),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(80.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0,10.0),
              )
            ],
            border: Border.all(
              color: Colors.white,
              width: 3.50,
            ),
          ),
    ),
    );
    final name = Center(
      child: Container(
        margin: EdgeInsets.only(
          top:15.0,
        ),
      child: Text(

        nombre,
        style: TextStyle(
          color: Colors.black,
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      ),
    );
    final description = Center(
      child: Container(
        margin: EdgeInsets.only(
          top:15.0,
          right: 20.0,
          left: 20.0,
        ),
      child: Text(
        descriccion,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: Color.fromRGBO(2, 79, 20, 1),
          fontSize: 16.0,
        ),
      ),
      ),
    );

    final title = Center(
      child: Container(
        margin: EdgeInsets.only(
          top:15.0,
        ),
        child: Text(
          titulo,
          style: TextStyle(
            color: Color.fromRGBO(2, 79, 20, 1),
            fontSize: 22.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        background,
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / 6),
                profileImage,
                name,
                title,
                description,
              ],
            ),
          ),
        )
      ],

    );
  }
}