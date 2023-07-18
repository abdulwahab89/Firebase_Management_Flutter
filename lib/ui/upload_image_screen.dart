import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorials/utils/utils.dart';
import 'package:firebase_tutorials/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);
  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _file;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('post');
  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
      } else {
        print('no image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getImageGallery();
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                )),
                height: 300,
                width: 200,
                child: _file != null
                    ? Image.file(_file!.absolute)
                    : Icon(Icons.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundButton(
                title: 'Upload',
                onPress: () async {
                  firebase_storage.Reference ref = firebase_storage
                      .FirebaseStorage.instance
                      .ref('/foldername /' +
                          DateTime.now().millisecond.toString());
                  firebase_storage.UploadTask uploadTask =
                      ref.putFile(_file!.absolute);
                  await Future.value(uploadTask)
                      .then((value) => Utils.messageBar('sucess'))
                      .onError((error, stackTrace) =>
                          Utils.messageBar(error.toString()));
                  var url = await ref.getDownloadURL();
                  dbRef.child('1').set({
                    'id': DateTime.now().millisecond.toString(),
                    'title': url.toString(),
                  });
                }),
          )
        ],
      ),
    );
  }
}
