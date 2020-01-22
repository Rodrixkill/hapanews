import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SideMenu.dart';

class About extends StatelessWidget {
  final topBar = new AppBar(
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

  @override
  Widget build(BuildContext context) {
    String audicion=
        "Realizamos audiciones cada 3 meses y nuestros alumnos graduados podrán audicionar a la University of Southern California desde Bolivia. HAPA es la primera Academia de Actuación y Desarrollo Personal sin fronteras que conecta a Bolivia con Hollywood y con todas las nuevas sedes que se vayan formando en el mundo.";
    String pactuar =
        "HAPA cuenta con más de 5 años de experiencia en el mercado boliviano, tiempo en el que se graduaron mas de 250 alumnos de la ciudad de La Paz, El Alto, Santa Cruz, Cochabamba, Tarija y Sucre. Nuestros graduados son personas de distintas áreas profesionales, que alcanzaron en nuestras aulas un profundo e importante desarrollo personal a través del conocimiento y práctica de las últimas técnicas de actuación que se practican en reconocidas universidades internacionales.";
    String programa=
        "El programa es una CAPACITACIÓN que tiene una duración de 15 módulos que son facilitados por actores destacados de Bolivia. Conecta tres ciudades: La Paz, Santa Cruz y Cochabamba además de contar con la presencia virtual de actores de Hollywood mensualmente.";
    final url = Center(
      child: RaisedButton(
        color: Color.fromRGBO(230, 153, 0,1),
        onPressed: _launchURL,
        child: Text('Ir a --> academyhapa.com'),
      ),
    );
    //PARTE 1
    final title1 = new Container(
      child: Text(
        'Sobre Nosotros',
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 23.0,
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

    final descriptionField1 = Container(
      margin: new EdgeInsets.only(
        top: 5.0,
        right: 0.0,
        left: 0.0,
      ),
      constraints: BoxConstraints(
          maxWidth:360
      ),
      child: new Text(
          pactuar,
          style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff56575a)
          ),
          textAlign: TextAlign.justify
      ),
    );
    final row1= Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        descriptionField1
      ],
    );
    //PARTR 2
    final title2 = new Container(
      child: Text(
        'Programa de Actuación',
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 23.0,
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

    final descriptionField2 = Container(
      margin: new EdgeInsets.only(
        top: 5.0,
        right: 0.0,
        left: 0.0,
      ),
      constraints: BoxConstraints(
          maxWidth:360
      ),
      child: new Text(
          programa,
          style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff56575a)
          ),
          textAlign: TextAlign.justify
      ),
    );
    final row2= Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        descriptionField2
      ],
    );
    //PARTE 3
    final title3 = new Container(
      child: Text(
        'Audiciones',
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 23.0,
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

    final descriptionField3 = Container(
      margin: new EdgeInsets.only(
        top: 5.0,
        right: 0.0,
        left: 0.0,
      ),
      constraints: BoxConstraints(
          maxWidth:360
      ),
      child: new Text(
          audicion,
          style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xff56575a)
          ),
          textAlign: TextAlign.justify
      ),
    );
    final row3= Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        descriptionField3,
      ],
    );

    final text = new Column(
      children: <Widget>[
        title1,
        row1,
        title2,
        row2,
        title3,
        row3,
        url
      ],
    );
    return new Scaffold(

      appBar: topBar,
      drawer: new SideMenu(),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              text
            ],
          )
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.academyhapa.com/bolivia';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo conectar a $url';
    }
  }
}