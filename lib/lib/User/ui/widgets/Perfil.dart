import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/News/ui/screens/SideMenu.dart';
import 'package:hapaprueba/User/bloc/bloc_user.dart';
import '../screens/profilePage.dart';

class Perfil extends StatelessWidget {
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
    return new Scaffold(
      backgroundColor: Color.fromRGBO(243, 240, 210, 20), //TODO Cambiar color de fondo
        appBar: topBar,
        drawer: new SideMenu(),
        body: CupertinoTabView(
          builder: (BuildContext context) {
            return BlocProvider<UserBloc>(
              bloc: UserBloc(),
              child: ProfilePage('Cuando recuperes o descubras algo que alimenta tu alma y te trae  alegría, encargate de quererte lo suficiente y hazle un espacio en tu vida (Jean Shinoda Bolen)', 'assets/images/background1.png'),
            );
          },
        ) );
  }
}
