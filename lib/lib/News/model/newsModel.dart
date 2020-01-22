import 'package:flutter/cupertino.dart';

class NewsModel{
  final String title;
  final String content;
  final String photoURL;

  NewsModel({
    Key key,
    @required this.photoURL,
    @required this.title,
    @required this.content

  });
}