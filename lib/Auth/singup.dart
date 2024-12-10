// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componants/Logo.dart';
import 'package:flutter_application_1/Componants/MaterialButtons.dart';
import 'package:flutter_application_1/Componants/TextFormField.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController Username = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Logo(
                    logo_path: 'assets/images/download (1).jpeg',
                  ),
                  const Text(
                    "Singup",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Signup to Continue using the App ",
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextform(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Can`t be Empty";
                      }
                    },
                    mycontroller: Username,
                    hinttext: "Enter Username",
                    title: "Username",
                  ),
                  CustomTextform(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Can`t be Empty";
                      }
                    },
                    mycontroller: email,
                    hinttext: "Enter email",
                    title: "Email",
                  ),
                  CustomTextform(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Can`t be Empty";
                      }
                    },
                    mycontroller: password,
                    hinttext: "Enter Password",
                    title: "Password",
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    child: const Text(
                      " Forget Password ?? ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomMaterialButtons(
                text: " Signup  ",
                Bcolor: Colors.orangeAccent,
                hsized: 20,
                image_path: "",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      Navigator.of(context).pushReplacementNamed("login");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                }),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("login");
              },
              child: const Center(
                child: Text.rich(
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    TextSpan(children: [
                      TextSpan(text: "You have an account? Go to "),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      )
                    ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
