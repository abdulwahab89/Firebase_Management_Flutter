import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorials/ui/auth/login_screen.dart';
import 'package:firebase_tutorials/utils/utils.dart';
import 'package:firebase_tutorials/widgets/round_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formState = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void signUp() {
    _firebaseAuth
        .createUserWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString())
        .then((value) {})
        .onError((error, stackTrace) {
      Utils.messageBar(error.toString());
    });
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign up "),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
              key: _formState,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        prefixIcon: const Icon(Icons.email),
                        hintText: "email",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter password";
                          }
                        }),
                  ],
                ),
              )),
          RoundButton(
              title: "Sign up",
              onPress: () {
                if (_formState.currentState!.validate()) {
                  signUp();
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text('Login')),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
