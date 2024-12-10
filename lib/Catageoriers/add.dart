import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componants/MaterialButtons.dart';
import 'package:flutter_application_1/Componants/TextFormField.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AddCatagorie extends StatefulWidget {
  const AddCatagorie({super.key});

  @override
  State<AddCatagorie> createState() => _AddCatagorieState();
}

class _AddCatagorieState extends State<AddCatagorie> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  TextEditingController name = TextEditingController();

  ///
  ///
  ///
  CollectionReference Catagories =
      FirebaseFirestore.instance.collection('catagories');
  bool isloading = false;
  AddCatagories() async {
    if (_formKey.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        DocumentReference response = await Catagories.add({
          'name': name.text,
          "id": FirebaseAuth.instance.currentUser!.uid,
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (routes) => false);
      } catch (e) {
        isloading = false;
        setState(() {});
        print(e);
      }
    }
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  ///
  ///
  ///
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Catagories"),
        ),
        body: Form(
          key: _formKey,
          child: isloading == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      CustomTextform(
                          mycontroller: name,
                          hinttext: "Name",
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Name is Empty";
                            }
                          },
                          title: "Name Catagories"),
                      SizedBox(
                        width: 120,
                        child: CustomMaterialButtons(
                            hsized: 30,
                            text: "Add",
                            Bcolor: Colors.amber,
                            onTap: () {
                              AddCatagories();
                            },
                            image_path: ""),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
