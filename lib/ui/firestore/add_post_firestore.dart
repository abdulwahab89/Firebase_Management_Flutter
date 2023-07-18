import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorials/utils/utils.dart';
import 'package:firebase_tutorials/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPostFireStore extends StatefulWidget {
  AddPostFireStore({Key? key}) : super(key: key);
  @override
  State<AddPostFireStore> createState() => _AddPostFireStoreState();
}

class _AddPostFireStoreState extends State<AddPostFireStore> {
  final _postController = TextEditingController();

  final firestore = FirebaseFirestore.instance.collection('wahab');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextFormField(
              controller: _postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RoundButton(
                title: 'Post',
                onPress: () {
                  String id = DateTime.now().millisecond.toString();
                  firestore
                      .doc(id)
                      .set({
                        'title': _postController.text.toString(),
                        'id': id,
                      })
                      .then((value) => Utils.messageBar('Post sucessfully'))
                      .onError((error, stackTrace) =>
                          Utils.messageBar(error.toString()));
                }),
          ),
        ],
      ),
    );
  }
}
