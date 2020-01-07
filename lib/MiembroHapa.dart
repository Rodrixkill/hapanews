import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/HapaHome.dart';
import 'package:hapaprueba/SideMenu.dart';
import 'package:hapaprueba/main.dart';
import 'bloc_user.dart';

class MiembroHapa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MiembroHapa();
  }

}
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


UserBloc userBloc;

class _MiembroHapa extends State<MiembroHapa> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    userBloc = BlocProvider.of(context);
    return Scaffold(
      appBar: topBar,
      drawer: new SideMenu(),
      body: _handleCurrentSession(),
    );
  }

  Widget _handleCurrentSession(){
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData || snapshot.hasError){
          return signInGoogleUI();
        }else{
          return HapaHome();
        }
      },
    );
  }
  Widget signInGoogleUI(){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
            // Aqui viene el fondo de la pantalla
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 65.0, bottom: 20.0),
              child: Center(
                child: Text("Bienvenido a Noticias HAPA",
                style: TextStyle(
                fontSize: 40.0,
                color: Colors.black45,
                fontWeight: FontWeight.bold
              ),)),),
              _signInButton(context),
            ],
          )
        ],
      ),
    );
  }

}
  Widget _signInButton(context) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        userBloc.signIn().then((FirebaseUser user) => print("El usuario es ${user.displayName}"));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

