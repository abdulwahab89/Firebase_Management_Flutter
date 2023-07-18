import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorials/ui/add_post.dart';
import 'package:firebase_tutorials/ui/auth/login_screen.dart';
import 'package:firebase_tutorials/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final _searchController = TextEditingController();
  final _dialogueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.login_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //       if (!snapshot.hasData) {
          //         return CircularProgressIndicator();
          //       } else {
          //         Map<dynamic, dynamic> map =
          //             snapshot.data!.snapshot!.value as dynamic;
          //         List<dynamic> list = [];
          //         list = map.values.toList();
          //         return ListView.builder(
          //             itemCount: snapshot.data!.snapshot.children.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 title: Text(list[index]['name'].toString()),
          //               );
          //             });
          //       }
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: ' search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('name').value.toString();
                  if (_searchController.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('name').value.toString()),
                      trailing: PopupMenuButton(
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialogue(title,
                                      snapshot.child('id').value.toString());
                                  // setState(() {});
                                },
                                leading: Icon(Icons.edit),
                                title: Text('edit'),
                              )),
                          PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  ref
                                      .child(
                                          snapshot.child('id').value.toString())
                                      .remove()
                                      .then((value) =>
                                          Utils.messageBar('removed'))
                                      .onError((error, stackTrace) =>
                                          Utils.messageBar(error.toString()));
                                },
                                leading: Icon(Icons.delete),
                                title: Text('delete'),
                              )),
                        ],
                      ),
                    );
                  } else if (title.toLowerCase().contains(
                      _searchController.text.toLowerCase().toString())) {
                    return ListTile(
                      title: Text(snapshot.child('name').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }

  Future<void> showMyDialogue(String title, String id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          _dialogueController.text = title;
          return AlertDialog(
            title: Text('Update'),
            content: Container(
              height: 50,
              width: 100,
              child: TextField(
                controller: _dialogueController,
                decoration: InputDecoration(
                  hintText: 'update title',
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref
                      .child(id)
                      .update({
                        'name': _dialogueController.text.toString(),
                      })
                      .then((value) => Utils.messageBar('Updated'))
                      .onError((error, stackTrace) =>
                          Utils.messageBar(error.toString()));
                },
                child: Text('Update'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }
}
