import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorials/ui/firestore/add_post_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({Key? key}) : super(key: key);
  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final ref = FirebaseFirestore.instance.collection('wahab').snapshots();

  final fireStore = FirebaseFirestore.instance.collection('wahab');
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostFireStore()));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: ref,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                snapshot.data!.docs[index]['title'].toString()),
                            subtitle:
                                Text(snapshot.data!.docs[index].id.toString()),
                            trailing: PopupMenuButton(
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showMyDialogue(
                                            snapshot.data!.docs[index]['title']
                                                .toString(),
                                            snapshot.data!.docs[index].id
                                                .toString());
                                      },
                                      title: const Text('update'),
                                    )),
                                PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        fireStore
                                            .doc(snapshot.data!.docs[index].id
                                                .toString())
                                            .delete();
                                      },
                                      title: const Text('delete'),
                                    )),
                              ],
                            ),
                          );
                        }));
              }),
        ],
      ),
    );
  }

  Future<void> showMyDialogue(String title, String id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          _controller.text = title;
          return AlertDialog(
            content: Container(
              height: 50,
              width: 100,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'title name',
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    fireStore.doc(id).update({
                      'title': _controller.text.toString(),
                    });
                  },
                  child: const Text('Update')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
            ],
          );
        });
  }
}
