import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componants/Logo.dart';
import 'package:flutter_application_1/Componants/MaterialButtons.dart';
import 'package:flutter_application_1/Componants/TextFormField.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;
  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain t he auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Login to Continue using the App ",
                            style: TextStyle(fontSize: 20, color: Colors.grey)),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextform(
                          mycontroller: email,
                          hinttext: "Enter email",
                          title: "Email",
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Can`t be Empty";
                            }
                          },
                        ),
                        CustomTextform(
                          mycontroller: password,
                          hinttext: "Enter Password",
                          title: "Password",
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Can`t be Empty";
                            }
                          },
                        ),
                        InkWell(
                          onTap: () async {
                            if (email.text.isEmpty) {
                              Get.snackbar("Error",
                                  "Please Enter Email before you Click on Forget Password");
                              return;
                            }
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email.text);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Password Reset"),
                                      content: const Text(
                                          "Password Reset Link has been sent to your email"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Ok"))
                                      ],
                                    );
                                  });
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            child: const Text(
                              " Forget Password ?? ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomMaterialButtons(
                    Bcolor: Colors.orangeAccent,
                    text: " Login  ",
                    hsized: 20,
                    image_path: "",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          isloading = true;
                          setState(() {});
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          isloading = false;
                          setState(() {});
                          if (credential.user!.emailVerified) {
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          } else {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            Get.snackbar(
                              "لايمكن تسجيل الدخول ",
                              " يرجى تاكيد بريدك الالكتروني و تفعيله ",
                              snackPosition: SnackPosition.TOP,
                              animationDuration: Duration(seconds: 2),
                              colorText: Colors.white,
                              backgroundColor: Colors.deepOrange,
                              duration: Duration(seconds: 5),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                           isloading = false;
                          setState(() {});
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      } else {
                        print("Can`t Not Valid");
                      }
                    },
                  ),
                  CustomMaterialButtons(
                    Bcolor: Colors.deepOrange,
                    hsized: 30,
                    image_path: "assets/images/download.jpeg",
                    onTap: () {
                      // signInWithGoogle();
                    },
                    text: "Login with Google ",
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("signup");
                    },
                    child: const Center(
                      child: Text.rich(
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          TextSpan(children: [
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: "Register",
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
