import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/User/bloc/bloc_user.dart';
import 'package:hapaprueba/User/ui/widgets/circle_button.dart';

class ProfilePage extends StatelessWidget{
  String backgroundPic = "assets/images/background1.png";
  var cont;
  String descriccion = "Cuando recuperes o descubras algo que alimenta tu alma y te trae  alegría, encargate de quererte lo suficiente y hazle un espacio en tu vida (Jean Shinoda Bolen)";
  UserBloc userBloc;
  ProfilePage(this.descriccion, this.backgroundPic);



  @override
  Widget build(BuildContext context) {
    cont = context;
    userBloc = BlocProvider.of<UserBloc>(context);
    return StreamBuilder(
      stream: userBloc.streamFirebase,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.none:
            return CircularProgressIndicator();
          case ConnectionState.active:
            return showProfileData(snapshot);
          case ConnectionState.done:
            return showProfileData(snapshot);
        }
      },
    );
    /*final background = Container(
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
            borderRadius: BorderRadius.all( Radius.circular(80.0)),
    //        shape: BoxShape.circle,
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
          color: Color(0xFF799497),
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
            color: Color(0xFF799497),
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
                CircleButton(text: "Cerrar Sesión", onPressed: () {
                  userBloc.signOut();
                }, width: 300.0, height: 50.0),
              ],
            ),
          ),
        )
      ],

    );*/
  }

  Widget showProfileData(AsyncSnapshot snapshot){
    if(!snapshot.hasData || snapshot.hasError){
      print("No logeado");
      return Container(
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 50.0
        ),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la informacion, porfavor haz login")
          ],
        ),
      );
    }else{
      print("Logeado");final background = Container(
          width: MediaQuery.of(cont).size.width,
          height: MediaQuery.of(cont).size.height / 3.5 ,
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
             // image: AssetImage(profipic),
              image: NetworkImage(snapshot.data.photoUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all( Radius.circular(80.0)),
            //        shape: BoxShape.circle,
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

            snapshot.data.displayName,
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
              color: Color(0xFF799497),
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
            snapshot.data.email,
            style: TextStyle(
              color: Color(0xFF799497),
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
                  SizedBox(height: MediaQuery.of(cont).size.height / 6),
                  profileImage,
                  name,
                  title,
                  description,
                  CircleButton(text: "Cerrar Sesión", onPressed: () {
                    userBloc.signOut();
                  }, width: 300.0, height: 50.0),
                ],
              ),
            ),
          )
        ],

      );
    }
  }
}