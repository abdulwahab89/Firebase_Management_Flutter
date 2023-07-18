import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/utils/utils.dart';
import 'package:firebase_tutorials/widgets/round_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'enter email',
              ),
            ),
          ),
          RoundButton(
              title: 'Forgot',
              onPress: () {
                _auth
                    .sendPasswordResetEmail(
                        email: _emailController.text.toString())
                    .then(
                  (value) {
                    Utils.messageBar('sent to email');
                  },
                ).onError((error, stackTrace) {
                  Utils.messageBar(error.toString());
                });
              })
        ],
      ),
    );
  }
}
