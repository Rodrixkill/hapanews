import 'package:flutter/cupertino.dart';

class User{
  final String uid;
  final String name;
  final String email;
  final String description;
  final String photoURL;

  User({
    Key key,
    @required this.email,
    @required this.photoURL,
    this.uid,
    this.name,
    this.description

});
}