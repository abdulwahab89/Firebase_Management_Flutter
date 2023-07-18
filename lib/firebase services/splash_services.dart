import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/ui/auth/login_screen.dart';
import 'package:firebase_tutorials/ui/firestore/firestore_screen.dart';
import 'package:firebase_tutorials/ui/post.dart';
import 'package:firebase_tutorials/ui/upload_image_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const PostScreen())); /*
            timer is used because time is required for the splashscreen to build its main scaffold widget then call the islogin method
            not using timer will cause to call the function while the function is already in build-phase.
            */
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }
}
