import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/News/ui/screens/HapaHome.dart';
import 'package:hapaprueba/User/bloc/bloc_user.dart';
import 'Anunciar.dart';
import 'About.dart';
import '../../../User/ui/screens/MiembroHapa.dart';
import '../../../User/ui/widgets/Perfil.dart';


class SideMenu extends StatelessWidget{
  final textStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(98, 86, 86, 1)
  );
  @override
  Widget build(BuildContext context) {
    return Theme(

        data: Theme.of(context).copyWith(
          //other styles
        ),
        child: new Drawer(
          child: container(context),

        )
    );
  }
  Container container(context){
    return new Container(
        color: new Color.fromRGBO(243, 240, 210, 20),
        child: new ListView(

          children: <Widget>[
            new DrawerHeader(
              decoration:new BoxDecoration(
                  border: Border.all(
                    color: new Color.fromRGBO(243, 240, 210, 20), //                   <--- border color
                    width: 5.0,
                  ),
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/hapa1.png")
                  )

              ) ,
            ),
            new ListTile(

              title: new Text("Home",style: textStyle,),
              trailing: new Icon(Icons.home),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new HapaHome()));
              },
            ),
            new ListTile(
              title: new Text("Quiero Anunciar",style: textStyle),
              trailing: new Icon(Icons.send),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                  return BlocProvider<UserBloc>(
                      bloc: UserBloc(),
                      child:new Anunciar()
                  );
                }));
              },
            ),
            new ListTile(
              title: new Text("Perfil",style: textStyle),
              trailing: new Icon(Icons.account_box),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new Perfil()));
              },
            ),
            new ListTile(
              title: new Text("Soy miembro hapa",style: textStyle),
              trailing: new Icon(Icons.airplay),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new MiembroHapa()));
              },
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child:ListTile(

                title: new Text("Acerca de Nosotros",style: textStyle),
                trailing: new Icon(Icons.info),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new About()));
                },
              ),
            )
          ],
        )
    );
  }

}