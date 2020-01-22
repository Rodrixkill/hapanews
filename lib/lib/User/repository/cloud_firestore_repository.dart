import 'package:hapaprueba/News/ui/widgets/news.dart';
import 'package:hapaprueba/User/model/user.dart';

import 'cloud_firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CloudFirestoreRepository{
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateUserDataFirestore(User user) => _cloudFirestoreAPI.updateUserData(user);
  List<News> buildNews(List<DocumentSnapshot> newsListSnapshot)=> _cloudFirestoreAPI.buildNews(newsListSnapshot);



  }