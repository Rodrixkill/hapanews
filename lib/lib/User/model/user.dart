import 'package:flutter/cupertino.dart';

class User{
  final String uid;
  final String name;
  final String email;
  final String description;
  final String photoURL;

  User({
    Key key,
    this.uid,
    this.name,
    @required this.email,
    @required this.photoURL,
    this.description

});
}