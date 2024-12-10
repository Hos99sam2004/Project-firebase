import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Additional_Page_not_in_App/Image_picker.dart';
import 'package:flutter_application_1/Auth/login.dart';
import 'package:flutter_application_1/Auth/singup.dart';
import 'package:flutter_application_1/Catageoriers/add.dart';
import 'package:flutter_application_1/Additional_Page_not_in_App/Filtering.dart';
import 'package:flutter_application_1/Myhomepage.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

///
///
///      hossam992004@gmail.com
///      hos99sam2004
///
///       nasrhossam256@gmail.com
///         hoSSam992004nasr
///
///
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print(
            '==============================================================User is currently signed out!');
      } else {
        print(
            ' ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++User is signed in!');
      }
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        "signup": (context) => const SingupScreen(),
        "login": (context) => const LoginScreen(),
        "homepage": (context) => const Myhomepage(),
        "AddCategory": (context) => const AddCatagorie(),
        "filterfirestore": (context) => const FilteringFireStore(),
        "image": (context) => const imagepicker(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.grey.shade400,
            titleTextStyle: TextStyle(
              color: Colors.orange,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.orange),
          )),
      // home: (FirebaseAuth.instance.currentUser != null &&
      //       FirebaseAuth.instance.currentUser!.emailVerified)
      //     ? Myhomepage()
      //     : LoginScreen(),
      home: FilteringFireStore(),
    );
  }
}
