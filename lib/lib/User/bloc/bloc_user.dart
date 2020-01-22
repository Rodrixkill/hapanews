import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/News/ui/widgets/news.dart';
import 'package:hapaprueba/User/model/user.dart';
import 'package:hapaprueba/User/repository/cloud_firestore_api.dart';
import 'package:hapaprueba/User/repository/cloud_firestore_repository.dart';
import '../repository/auth_repository.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  //Flujo de datos
  Stream<FirebaseUser> streamFirebase = FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => streamFirebase;


  // SignIn con Google
  Future<FirebaseUser> signIn(){
    return _auth_repository.signInFirebase();
  }


  getUser() async{
    return _auth_repository.getUser();
  }

  signOut(){
    _auth_repository.signOut();
  }


  //Registrar Usuario Firestore

  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(User user) => _cloudFirestoreRepository.updateUserDataFirestore(user);
  Stream<QuerySnapshot> newsListStream = Firestore.instance.collection(CloudFirestoreAPI().NEWS).snapshots();
  Stream<QuerySnapshot> get newsStream => newsListStream;
  List<News> buildNews(List<DocumentSnapshot> newsListSnapshot) => _cloudFirestoreRepository.buildNews(newsListSnapshot);



    @override
  void dispose() {
    // TODO: implement dispose
  }

}