import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hapaprueba/News/model/newsModel.dart';
import 'package:hapaprueba/News/ui/widgets/news.dart';
import 'package:hapaprueba/User/model/user.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String NEWS = "news";

  final Firestore _db = Firestore.instance;

  void updateUserData(User user) async{
    DocumentReference ref = _db.collection(USERS).document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'description': user.description,
      'lastSignIn': DateTime.now()

    }, merge: true);
  }

  List<News> buildNews(List<DocumentSnapshot> newsListSnapshot){
    List<News> newsList = List<News>();
    newsListSnapshot.forEach((n) {
      newsList.add(News(
          NewsModel(
            photoURL: n.data['image'],
            title: n.data['title'],
            content: n.data['content']
      )
      ));
    });
    return newsList;
    
  }

}