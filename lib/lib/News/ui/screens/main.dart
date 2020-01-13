import 'package:flutter/material.dart';
import 'package:hapaprueba/User/bloc/bloc_user.dart';
import 'HapaHome.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: new MaterialApp(
        title: 'Hapa',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            primaryColor: Colors.black,
            primaryIconTheme: IconThemeData(color: Colors.black),
            primaryTextTheme: TextTheme(
                title: TextStyle(color: Colors.black,fontFamily: "Aveny")
            )
        ),
        home: new HapaHome(),
      ),
      bloc: UserBloc(),
    );
  }

}