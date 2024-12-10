import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Componants/MaterialButtons.dart';
import 'package:flutter_application_1/Componants/TextFormField.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class EditCatagorie extends StatefulWidget {
  final String docid;
  final String oldname;
  const EditCatagorie({super.key, required this.docid, required this.oldname});

  @override
  State<EditCatagorie> createState() => _EditCatagorieState();
}

class _EditCatagorieState extends State<EditCatagorie> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  TextEditingController name = TextEditingController();

  ///
  CollectionReference Catagories =
      FirebaseFirestore.instance.collection('catagories');
  bool isloading = false;
  EditCatagories() async {
    if (_formKey.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        await Catagories.doc(widget.docid)
            .set({'name': name.text}, SetOptions(merge: true));
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
  void initState() {
    super.initState();
    name.text = widget.oldname;
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
          title: Text("Edit Catagories"),
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
                            text: "Save",
                            Bcolor: Colors.amber,
                            onTap: () {
                              EditCatagories();
                            },
                            image_path: ""),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
