import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorials/utils/utils.dart';
import 'package:firebase_tutorials/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final _postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _postController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "What's on your mind?",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        RoundButton(
            title: 'Post',
            onPress: () {
              String id = DateTime.now().millisecond.toString();
              databaseRef
                  .child(id)
                  .set({
                    'id': id,
                    'name': _postController.text.toString(),
                  })
                  .then((value) => Utils.messageBar("Sucessfully posted"))
                  .onError((error, stackTrace) =>
                      Utils.messageBar(error.toString()));
            }),
      ],
    ));
  }
}
