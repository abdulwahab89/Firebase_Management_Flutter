import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/ui/firestore/firestore_screen.dart';
import 'package:firebase_tutorials/ui/post.dart';
import 'package:firebase_tutorials/utils/utils.dart';
import 'package:firebase_tutorials/widgets/round_button.dart';
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  String? verificationId;
  VerifyCodeScreen({required this.verificationId, Key? key}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _pinCodeController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _pinCodeController,
              decoration: InputDecoration(
                hintText: "Enter 6 xxxxxx code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            RoundButton(
                title: 'Verify',
                onPress: () {
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId.toString(),
                      smsCode: _pinCodeController.text.toString());

                  firebaseAuth
                      .signInWithCredential(credential)
                      .then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FireStoreScreen())))
                      .onError((error, stackTrace) =>
                          Utils.messageBar(error.toString()));
                })
          ],
        ),
      ),
    );
  }
}
