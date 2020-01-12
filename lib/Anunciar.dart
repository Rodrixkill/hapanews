import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:hapa/SideMenu.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pendingNews.dart';
import 'package:firebase_database/firebase_database.dart';

class Anunciar extends StatelessWidget {
  final topBar = new AppBar(
    backgroundColor: new Color.fromRGBO(243, 232, 178, 1),
    centerTitle: true,
    elevation: 1.0,
    title:
        SizedBox(height: 35.0, child: Image.asset("assets/images/hapa1.png")),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Icon(Icons.send),
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

  void _display() {
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
    setState(() {
      StorageUploadTask _uploadTask =
          _storage.ref().child(storageUrl).putFile(_imageFile);
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
                    : Text('Inserta una imagen'),
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
