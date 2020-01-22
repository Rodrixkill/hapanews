import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/News/ui/widgets/news.dart';
import 'package:hapaprueba/User/bloc/bloc_user.dart';

class NewsList extends StatelessWidget{
  UserBloc userBloc;
  List img = ["assets/images/act1.png","assets/images/dance1.png","assets/images/movie1.png","assets/images/other1.png" ];
  String descriptionDummy = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
 //     mainAxisAlignment: MainAxisAlignment.start,
      child: StreamBuilder(
          stream: userBloc.newsStream,
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return Column(
                  children: userBloc.buildNews(snapshot.data.documents),
                );
              case ConnectionState.active:
                return Column(
                  children: userBloc.buildNews(snapshot.data.documents),
                );
              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                return Column(
                  children: userBloc.buildNews(snapshot.data.documents),
                );
            }
          },
        ),
//      children: <Widget>[
//        new News(img[0], "Act 1", descriptionDummy),
//        new News(img[1] , "Dance 1", descriptionDummy),
//        new News(img[2] , "Movie 1" ,descriptionDummy),
//        new News(img[3] , "Other" ,descriptionDummy),
//      ],
    );
  }


}