import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:hapaprueba/User/bloc/bloc_user.dart';
import 'package:hapaprueba/User/ui/widgets/circle_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'SideMenu.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

//import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../model/pendingNews.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


String emailUser;
final Firestore _db = Firestore.instance;
final FirebaseDatabase database = FirebaseDatabase.instance;
CollectionReference ref = _db.collection("users");

AsyncSnapshot snapshotUser;

int esUsuarioPermitido;
class Anunciar extends StatelessWidget {

  UserBloc userBloc;

  final topBar = new AppBar(
    backgroundColor: new Color.fromRGBO(243, 232, 178, 1),
    centerTitle: true,
    elevation: 1.0,
    title:
    SizedBox(height: 35.0, child: Image.asset("assets/images/hapa1.png")),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),

      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return new Scaffold(
        appBar: topBar,
        drawer: new SideMenu(),
        body: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
         builder: (BuildContext context, AsyncSnapshot snapshot){
              return showAnunciarData(snapshot);

    },
    ));
  }
}

Widget showAnunciarData(AsyncSnapshot snapshot) {
  if (!snapshot.hasData || snapshot.hasError) {
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
          Text("Para anunciar es necesario estar logeado en la app")
        ],
      ),
    );
  } else {
      ref.where("correo", isEqualTo: snapshot.data.email).snapshots().listen(
      (data) => {
        if(data.documents.isEmpty){
          esUsuarioPermitido = 0
        }else{
          esUsuarioPermitido = 1
        }
      }
  );
      if(esUsuarioPermitido == 1){
        return new ImageCapture();
      }else{
        snapshotUser = snapshot;
        return new Solicitud();
      }



  };
}



class Solicitud extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Text(
          "Usted no esta autorizado para publicar noticias, si desea contribuir con noticias porfavor haga click en el siguiente boton"
        ),
        CircleButton(text: "Solicitar Ser Miembro", onPressed: () {
          final DBref = FirebaseDatabase.instance.reference().child("pendingUsers").push().set({
            "correo": snapshotUser.data.email,
          });
          solicitudAlert(context);
        }, width: 300.0, height: 50.0)
      ],
    );

     ;
  }

  Future<Alert> solicitudAlert(BuildContext context){
    Alert(context: context,title: 'Hapa Noticias',content: Text('  Su solicitud fue enviada para su revisión'),buttons: [
      DialogButton(
        child: Text(
          "Cerrar",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
        color: Color.fromRGBO(230, 153, 0,1) ,
      )
    ]).show();

  }

}

class ImageCapture extends StatefulWidget {
  ImageCapture({Key key}) : super(key: key);

  @override
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  PendingNews pendingNews;
  DatabaseReference _databaseReference;
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File _image = await ImagePicker.pickImage(source: source)
        .whenComplete(() => {log('lo logre')});
    log(_image.toString());
    setState(() {
      _imageFile = _image;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(sourcePath: _imageFile.path);
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  StorageUploadTask _uploadTask;

  Future<Alert> _display() {
    Alert(context: context,title: 'Hapa Noticias',content: Text('  Su noticia esta siendo procesada'),buttons: [
      DialogButton(
        child: Text(
          "Cerrar",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
        color: Color.fromRGBO(230, 153, 0,1) ,
      )
    ]).show();
    String url = DateTime.now().toIso8601String();
    int ind = _imageFile.path.lastIndexOf("/");
    String newUrl = _imageFile.path.substring(ind + 1, _imageFile.path.length);
    String fullUrl = "$url$newUrl";


    pendingNews =
        PendingNews(titleController.text, descController.text, fullUrl, url,emailUser);
    final DBref = FirebaseDatabase.instance
        .reference()
        .child("pendingNews")
        .push()
        .set(pendingNews.toJson());
    FirebaseStorage _storage = FirebaseStorage.instance;
    String storageUrl = 'images/$fullUrl';
    //Create a reference to the location you want to upload to in firebase
    StorageReference reference = _storage.ref().child("images/");
    setState(() async {
      _uploadTask = _storage.ref().child(storageUrl).putFile(_imageFile);
      _uploadTask.events.listen((event) {
        setState(() {
          bool _isLoading = true;
          double _progess = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
          log(_progess.toString());
        });
      }).onError((error) {
        //_scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(error.toString()), backgroundColor: Colors.red,) );
      });
      StorageTaskSnapshot storageTaskSnapshot = await _uploadTask.onComplete;
      if(_uploadTask.isSuccessful){
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        log(downloadUrl);
        return Alert(title: 'Noticias Hapa:',
            context: context,
            content: Text(' Le tiene el agrado de informarle que su noticia fue subida exitosamente'),
            buttons: [
              DialogButton(
                child: Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
                color: Color.fromRGBO(230, 153, 0,1) ,
              )
            ]
        ).show();
      }else{
        return Alert(title: 'Noticias Hapa:',
            context: context,
            content: Text(' Le informa que no se pudo subir la imagen al servidor verifique su calidad de internet'),
            buttons: [
              DialogButton(
                child: Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
                color: Color.fromRGBO(230, 153, 0,1) ,
              )
            ]
        ).show();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                new Container(
                  child: Text(
                    'Ingresa tu noticia a Hapa',
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 23.0,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  margin: new EdgeInsets.only(
                    top: 5.0,
                    right: 20.0,
                    left: 20.0,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                new TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.title),
                    hintText: 'Título de tu noticia',
                    labelText: 'Título',
                  ),
                ),
                new TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.description),
                    hintText: 'Ingresa la descripción de la noticia',
                    labelText: 'Descripción',
                  ),
                  autofocus: false,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () => _pickImage(ImageSource.camera)),
                      new IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: () => _pickImage(ImageSource.gallery)),
                    ]),
                _imageFile != null
                    ? Image.file(_imageFile)
                    : Text('Inserta una imagen para poder subir tu noticia'),
                _imageFile != null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.crop),
                      onPressed: _cropImage,
                    ),
                    FlatButton(
                      child: Icon(Icons.refresh),
                      onPressed: _clear,
                    ),
                    //Uploader(file: _imageFile)
                  ],
                )
                    : Text(''),
                if (_imageFile != null &&
                    titleController.text != " " &&
                    descController.text != " ") ...[
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        color: Color.fromRGBO(230, 153, 0, 1),
                        child: const Text('Crear noticia'),
                        onPressed: _display,
                      )),
                ],
              ],
            )));
  }
}

class Uploader extends StatefulWidget {
  final File file;

  Uploader({this.file});

  createState() => _UploaderState("title", "description");
}

class _UploaderState extends State<Uploader> {
  final String title;
  final String description;

  _UploaderState(this.title, this.description);

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://noticiashapa-107a9.appspot.com');
  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${title}${DateTime.now()}.png';
    //FirebaseDatabase database = new FirebaseDatabase();
    //DatabaseReference _userRef;=database.reference().child('user');
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
        onPressed: _startUpload,
        icon: Icon(Icons.cloud_upload),
        label: Text('Subiendo la noticia a la red'));
  }
}

/*

class Anunciar extends StatelessWidget {

  UserBloc userBloc;

  final topBar = new AppBar(
    backgroundColor: new Color.fromRGBO(243, 232, 178, 1),
    centerTitle: true,
    elevation: 1.0,
    title:
    SizedBox(height: 35.0, child: Image.asset("assets/images/hapa1.png")),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),

      )
    ],
  );

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: topBar, drawer: new SideMenu(), body: new ImageCapture());
  }
}

class ImageCapture extends StatefulWidget {
  ImageCapture({Key key}) : super(key: key);

  @override
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  PendingNews pendingNews;
  DatabaseReference _databaseReference;
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File _image = await ImagePicker.pickImage(source: source)
        .whenComplete(() => {log('lo logre')});
    log(_image.toString());
    setState(() {
      _imageFile = _image;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(sourcePath: _imageFile.path);
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  StorageUploadTask _uploadTask;

  Future<Alert> _display() {
    Alert(context: context,title: 'Hapa Noticias',content: Text('  Su noticia esta siendo procesada'),buttons: [
      DialogButton(
        child: Text(
          "Cerrar",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
        color: Color.fromRGBO(230, 153, 0,1) ,
      )
    ]).show();
    String url = DateTime.now().toIso8601String();
    int ind = _imageFile.path.lastIndexOf("/");
    String newUrl = _imageFile.path.substring(ind + 1, _imageFile.path.length);
    String fullUrl = "$url$newUrl";

    pendingNews =
        PendingNews(titleController.text, descController.text, fullUrl, url);
    final DBref = FirebaseDatabase.instance
        .reference()
        .child("pendingNews")
        .push()
        .set(pendingNews.toJson());
    FirebaseStorage _storage = FirebaseStorage.instance;
    String storageUrl = 'images/$fullUrl';
    //Create a reference to the location you want to upload to in firebase
    StorageReference reference = _storage.ref().child("images/");
    setState(() async {
      _uploadTask = _storage.ref().child(storageUrl).putFile(_imageFile);
      _uploadTask.events.listen((event) {
        setState(() {
          bool _isLoading = true;
          double _progess = event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble();
          log(_progess.toString());
        });
      }).onError((error) {
        //_scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(error.toString()), backgroundColor: Colors.red,) );
      });
      StorageTaskSnapshot storageTaskSnapshot = await _uploadTask.onComplete;
      if(_uploadTask.isSuccessful){
        String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        log(downloadUrl);
        return Alert(title: 'Noticias Hapa:',
            context: context,
            content: Text(' Le tiene el agrado de informarle que su noticia fue subida exitosamente'),
            buttons: [
              DialogButton(
                child: Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
                color: Color.fromRGBO(230, 153, 0,1) ,
              )
            ]
        ).show();
      }else{
        return Alert(title: 'Noticias Hapa:',
            context: context,
            content: Text(' Le informa que no se pudo subir la imagen al servidor verifique su calidad de internet'),
            buttons: [
              DialogButton(
                child: Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
                color: Color.fromRGBO(230, 153, 0,1) ,
              )
            ]
        ).show();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
  //  print("El email es: "+getEmail());
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                new Container(
                  child: Text(
                    'Ingresa tu noticia a Hapa',
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 23.0,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  margin: new EdgeInsets.only(
                    top: 5.0,
                    right: 20.0,
                    left: 20.0,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                new TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.title),
                    hintText: 'Título de tu noticia',
                    labelText: 'Título',
                  ),
                ),
                new TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.description),
                    hintText: 'Ingresa la descripción de la noticia',
                    labelText: 'Descripción',
                  ),
                  autofocus: false,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new IconButton(
                          icon: Icon(Icons.photo_camera),
                          onPressed: () => _pickImage(ImageSource.camera)),
                      new IconButton(
                          icon: Icon(Icons.photo_library),
                          onPressed: () => _pickImage(ImageSource.gallery)),
                    ]),
                _imageFile != null
                    ? Image.file(_imageFile)
                    : Text('Inserta una imagen para poder subir tu noticia'),
                _imageFile != null
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.crop),
                      onPressed: _cropImage,
                    ),
                    FlatButton(
                      child: Icon(Icons.refresh),
                      onPressed: _clear,
                    ),
                    //Uploader(file: _imageFile)
                  ],
                )
                    : Text(''),
                if (_imageFile != null &&
                    titleController.text != " " &&
                    descController.text != " ") ...[
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        color: Color.fromRGBO(230, 153, 0, 1),
                        child: const Text('Crear noticia'),
                        onPressed: _display,
                      )),
                ],
              ],
            )));
  }
}

class Uploader extends StatefulWidget {
  final File file;

  Uploader({this.file});

  createState() => _UploaderState("title", "description");
}

class _UploaderState extends State<Uploader> {
  final String title;
  final String description;

  _UploaderState(this.title, this.description);

  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://noticiashapa-107a9.appspot.com');
  StorageUploadTask _uploadTask;

  void _startUpload() {
    String filePath = 'images/${title}${DateTime.now()}.png';
    //FirebaseDatabase database = new FirebaseDatabase();
    //DatabaseReference _userRef;=database.reference().child('user');
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {

    return FlatButton.icon(
        onPressed: _startUpload,
        icon: Icon(Icons.cloud_upload),
        label: Text('Subiendo la noticia a la red'));
  }
}*/