import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class PendingNews{
  String key;
  String title;
  String description;
  String imageUrl;
  String dateF;
  PendingNews(this.title,this.description,this.imageUrl,this.dateF);
  PendingNews.fromSnapshot(DataSnapshot snapshot)
      : key= snapshot.key,
        title=snapshot.value["title"],
        description= snapshot.value["description"],
        imageUrl= snapshot.value["imageUrl"],
        dateF= snapshot.value["dateF"];

  toJson(){
    return {
      "title":title,
      "description":description,
      "imageUrl": imageUrl,
      "dateF":dateF,
    };
  }
}