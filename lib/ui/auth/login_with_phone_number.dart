import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/ui/auth/verify_code.dart';
import 'package:firebase_tutorials/utils/utils.dart';
import 'package:firebase_tutorials/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _pinCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: ' Enter phone number',
                ),
                keyboardType: TextInputType.phone,
                controller: _pinCodeController,
              ),
            ),
          ),
          RoundButton(
              title: "Log in",
              onPress: () {
                _auth.verifyPhoneNumber(
                    phoneNumber: _pinCodeController.text.toString(),
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      Utils.messageBar(e.toString());
                    },
                    codeSent: (String authenticationId, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(
                                  verificationId: authenticationId)));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils.messageBar(e.toString());
                    });
                // _auth.verifyPhoneNumber(
                //     phoneNumber: _pinCodeController.text.toString(),
                //     verificationCompleted: (_) {},
                //     verificationFailed: (e) {
                //       Utils.messageBar(e.toString());
                //     },
                //     codeSent: (String verification, int? token) {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => VerifyCodeScreen(
                //                     verificationId: verification,
                //                   )));
                //     },
                //     codeAutoRetrievalTimeout: (e) {
                //       Utils.messageBar(e.toString());
                //     });
              })
        ],
      ),
    );
  }
}
