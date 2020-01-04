import 'package:flutter/material.dart';
import 'package:hapa/SideMenu.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: Icon(Icons.send),
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
          fontSize: 25.0,
          fontWeight: FontWeight.w900,
          color: Colors.white
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
        right: 20.0,
        left: 20.0,
      ),
      constraints: BoxConstraints(
        maxWidth: 330
      ),
      child: new Text(
        pactuar,
        style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
        textAlign: TextAlign.center
      ),
      alignment: Alignment.centerLeft,
    );
    final container1= new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/other1.png"),
          )
      ),
      child: Column(
        children: <Widget>[
          title1,
          descriptionField1,
          divider(),
        ],
      )
    );
    //PARTR 2
    final title2 = new Container(
      child: Text(
        'Programa de Actuación',
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 25.0,
          fontWeight: FontWeight.w900,
            color: Colors.white
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
        right: 20.0,
        left: 20.0,
      ),
      constraints: BoxConstraints(
        maxWidth: 220,
      ),
      child: new Text(
          programa,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          textAlign: TextAlign.center
      ),

    );
    final container2= new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/dance1.png"),
            )
        ),
        child: Column(
          children: <Widget>[
            title2,
            descriptionField2,
            divider(),
          ],
        )
    );
    //PARTE 3
    final title3 = new Container(
      child: Text(
        'Audiciones',
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 25.0,
          fontWeight: FontWeight.w900,
            color: Colors.white
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
        right: 20.0,
        left: 20.0,
      ),
      child: new Text(
          audicion,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          textAlign: TextAlign.justify,
      ),
      alignment: Alignment.centerLeft,
    );
    final container3= new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/movie1.png"),
            )
        ),
        child: Column(
          children: <Widget>[
            title3,
            descriptionField3,
            divider(),
            url
          ],
        )
    );

    final text = new Column(
      children: <Widget>[
        container1,
        container2,
        container3,
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
  Divider divider(){
    return Divider(height: 25,);
  }
}
