import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/News/ui/screens/HapaHome.dart';
import 'package:hapaprueba/News/ui/screens/SideMenu.dart';
import 'package:hapaprueba/News/ui/screens/main.dart';
import 'package:hapaprueba/User/model/user.dart';
import 'package:hapaprueba/User/ui/screens/profilePage.dart';
import '../../bloc/bloc_user.dart';

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
      padding: const EdgeInsets.only(right: 12.0)
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
          Navigator.pop(context);
          return ProfilePage('Cuando recuperes o descubras algo que alimenta tu alma y te trae  alegría, encargate de quererte lo suficiente y hazle un espacio en tu vida (Jean Shinoda Bolen)', 'assets/images/background1.png');
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
        userBloc.signOut();
        userBloc.signIn().then((FirebaseUser user) {
          userBloc.updateUserData(User(
            uid: user.uid,
            name: user.displayName,
            email: user.email,
            photoURL: user.photoUrl,
          ));
        });
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

