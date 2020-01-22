import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/News/ui/screens/SideMenu.dart';
import 'package:hapaprueba/News/ui/widgets/newsList.dart';
import 'package:hapaprueba/User/bloc/bloc_user.dart';

class HapaHome extends StatelessWidget {
  final topBar = new AppBar(
    backgroundColor: new Color.fromRGBO(243, 232, 178, 1),
    centerTitle: true,
    elevation: 1.0,
    title: SizedBox(
        height: 45.0, child: Image.asset("assets/images/hapa1.png")),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),

      )
    ],
  );
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: topBar,
        drawer: new SideMenu(),
        body: CupertinoTabView(
          builder: (BuildContext context) {
            return BlocProvider<UserBloc>(
              bloc: UserBloc(),
              child:  ListView(
                children: <Widget>[
                  NewsList(),
                ],
              ),
            );
          },
        )







    );
  }
}
